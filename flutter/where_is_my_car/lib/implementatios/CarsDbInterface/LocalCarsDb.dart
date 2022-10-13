import 'package:localstorage/localstorage.dart';
import 'package:where_is_my_car/interfaces/CarsDbInterface.dart';
import 'package:where_is_my_car/long_base_64_img.dart';

class LocalCarsDb implements CarsDbInterface {
  final LocalStorage _db = LocalStorage("cars.json");

  LocalCarsDb() {
    init();
  }

  Future<void> init() async {
    await _db.ready;
    if (_db.getItem("cars") == null) {
      await _db.setItem("cars", [
        {
          "license": "4562APS",
          "brand": "Mercedes",
          "model": "C 300",
          "lastUpdate": "2022-11-12 12:00:00",
          "image": LongBase64Img.image,
          "position": {"latitude": 0.0, "longitude": 0.0}
        }
      ]);
    }
  }

  @override
  Future<bool> addCar(Map<String, dynamic> car) async {
    try {
      List<Map<String, dynamic>> cars = _db.getItem("cars") ?? [];
      cars.add(car);
      await _db.setItem("cars", cars);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<bool> deleteCar(String license) {
    try {
      List cars = _db.getItem("cars");
      cars.removeWhere((element) => element["license"] == license);
      _db.setItem("cars", cars);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<dynamic> getCar(String license) {
    List<Map<String, dynamic>> cars = _db.getItem("cars");
    Map<String, dynamic> car =
        cars.firstWhere((car) => car["license"] == license);
    return Future.value(car);
  }

  @override
  Future<List<dynamic>> getCars() {
    return Future.value(_db.getItem("cars"));
  }

  @override
  Future<bool> updateCar(String license, Map<String, dynamic> car) {
    try {
      List cars = _db.getItem("cars");
      cars.removeWhere((element) => element["license"] == license);
      cars.add(car);
      _db.setItem("cars", cars);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }
}
