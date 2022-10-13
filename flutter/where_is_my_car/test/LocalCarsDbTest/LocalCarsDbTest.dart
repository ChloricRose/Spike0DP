import 'package:flutter_test/flutter_test.dart';
import 'package:where_is_my_car/implementatios/CarsDbInterface/LocalCarsDb.dart';
import 'package:where_is_my_car/interfaces/CarsDbInterface.dart';

void main() {
  test("Test what type is saved on the file", ()async{
    CarsDbInterface carDb = LocalCarsDb();
    dynamic cars = await carDb.getCars();
    print(cars);
    expect(cars.runtimeType, List);
  });

}