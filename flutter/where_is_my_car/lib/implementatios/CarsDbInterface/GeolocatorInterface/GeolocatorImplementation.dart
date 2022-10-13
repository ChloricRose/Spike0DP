import 'package:geolocator/geolocator.dart';
import 'package:where_is_my_car/interfaces/GeolocatorInterface.dart';

class GeolocatorImplementation implements GeolocatorInterface {
  @override
  Future<Map<String, double>> getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permission denied');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return {"latitude": position.latitude, "longitude": position.longitude};
  }
}
