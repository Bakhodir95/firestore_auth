import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_auth/models/car.dart';
import 'package:firestore_auth/models/quiz.dart';
import 'package:firestore_auth/services/car_firbase_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CarController with ChangeNotifier {
  final _carsFirebaseService = CarsFirebaseService();

  Stream<QuerySnapshot> get list {
    return _carsFirebaseService.getCars();
  }

  Future<void> addCar(String name, File imageFile) async {
    await _carsFirebaseService.addCar(name, imageFile);
  }

  // void editCar(Car car) {
  //   _carsFirebaseService.edidCar(car);
  // }

  // void deleteCar() {
  //   // _questionFirebaseService.deleteQuestion()
  // }
}
