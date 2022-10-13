import 'package:flutter/material.dart';
import 'package:where_is_my_car/Cars/models/Car.dart';
import 'package:where_is_my_car/interfaces/CarsDbInterface.dart';

class CarProvider extends ChangeNotifier {
  Car _car = Car();
  get car => _car;
  CarsDbInterface db;

  /* Constructor only receiving CarsDbInterface */
  CarProvider(this.db);
}
