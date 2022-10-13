import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:where_is_my_car/Cars/ListCarScreen/Views/Widgets/carCard.dart';
import 'package:where_is_my_car/Cars/Models/Car.dart';
import 'package:where_is_my_car/interfaces/CarsDbInterface.dart';
import 'package:where_is_my_car/interfaces/GeolocatorInterface.dart';

class MapScreenProvider with ChangeNotifier {
  GeolocatorInterface geolocator;
  CarsDbInterface carDb;
  Widget selectedCar = Container();

  MapScreenProvider(this.geolocator, this.carDb);

  final MapController _mapController = MapController();
  LatLng _center = LatLng(0, 0);
  List<Marker> _markers = [];
  Widget _detailedCar = Container();

  get controller => _mapController;
  get center => _center;
  get markers => _markers;
  get detailedCar => _detailedCar;

  void clear() {
    _markers = [];
    print("Cleaning");
    notifyListeners();
  }

  Future<void> getCars() async {
    List<dynamic> encodedCars = await carDb.getCars();
    List<Car> cars = encodedCars.map((e) => Car.fromJson(e)).toList();
    for (Car car in cars) {
      _markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: car.position!,
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.car_rental),
            onPressed: () {
              _detailedCar = Dismissible(
                key: UniqueKey(),
                child: CarCard(),
              );
              notifyListeners();
            },
          ),
        ),
      );
    }
    notifyListeners();
  }

  void _addMarterToList(
    LatLng position,
  ) {
    _markers.add(
      Marker(
        point: position,
        width: 80,
        height: 80,
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Icon(
              Icons.arrow_downward,
              size: 40,
            ),
          ],
        ),
      ),
    );
    print("Map setted");
    notifyListeners();
  }

  Future<void> setCenter() async {
    Map geoPosition = await geolocator.getCurrentPosition();
    _center = LatLng(geoPosition["latitude"], geoPosition["longitude"]);
    _mapController.move(_center, 9.2);
    _addMarterToList(_center);
    notifyListeners();
  }

  Future<LatLng> getCenter() async {
    Map geoPosition = await geolocator.getCurrentPosition();
    return LatLng(geoPosition["latitude"], geoPosition["longitude"]);
  }
}
