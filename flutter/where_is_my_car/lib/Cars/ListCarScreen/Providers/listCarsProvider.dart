import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:where_is_my_car/Cars/models/Car.dart';
import 'package:where_is_my_car/interfaces/CarsDbInterface.dart';

class ListCarsProvider extends ChangeNotifier {

  CarsDbInterface db;

  ListCarsProvider(this.db);

  List<Car> _cars = [];
  get cars => _cars;

  getCars(){
    db.getCars().then((cars) {
      _cars = cars.map((car) => Car.fromJson(car)).toList();
      notifyListeners();
    });
  }

}
