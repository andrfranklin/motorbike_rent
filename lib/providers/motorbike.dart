import 'package:flutter/widgets.dart';
import 'package:motorbikes_rent/models/motorbike.dart';
import 'dart:async';

import 'package:motorbikes_rent/utils/api/motorbike.dart';

class MotorbikeProvider with ChangeNotifier {
  final _motorbikeApi = MotorbikeApi();
  List<MotorbikeModel> _motorbikes = [];

  MotorbikeProvider();

  List<MotorbikeModel> get motorbikes => [..._motorbikes];

  Future<void> loadMotorbikes() async {
    final response = await _motorbikeApi.loadMotorbike();
    _motorbikes = response;
    notifyListeners();
  }

  Future<MotorbikeModel?> readMotorbike({required String motorbikeId}) async {
    return _motorbikeApi.readMotorbike(motorbikeId: motorbikeId);
  }
}
