abstract class CarsDbInterface {
  Future<List<dynamic>> getCars();
  Future<dynamic> getCar(String license);
  Future<bool> addCar(Map<String, dynamic> car);
  Future<bool> updateCar(String license, Map<String, dynamic> car);
  Future<bool> deleteCar(String license);
}
