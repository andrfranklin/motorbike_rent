import 'package:flutter/widgets.dart';
import 'package:motorbikes_rent/models/motorbike.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:motorbikes_rent/utils/base_url.dart';

class MotorbikeProvider with ChangeNotifier {
  final List<Motorbike> _motorbikes = [];
  final String _baseUrlDb = '${BaseUrl.db}/motorbike';

  MotorbikeProvider();

  List<Motorbike> get motorbikes => _motorbikes;

  Future<void> loadMotorbike() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrlDb.json'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<String> ids = data.keys.toList();
      ids.forEach((id) {
        final model = data[id]['model'];
        final brandId = data[id]['brandId'];
        final price = double.parse(data[id]['price'].toString());
        final List<String> images = List<String>.from(data[id]['images']);
        if (_motorbikes.any((element) => element?.id == id)) return;
        _motorbikes.add(Motorbike(
            brandId: brandId,
            model: model,
            images: images,
            price: price,
            id: id));
      });
      notifyListeners();
    } catch (e) {
      print(e);
      throw Exception('Failed to load motorbikes');
    }
  }

  Future<void> createMotorbike(Motorbike motorbike) async {
    final response = await http.post(
      Uri.parse('$_baseUrlDb/motorbike'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "fields": {
          "brandId": {"referenceValue": 'brand/${motorbike.brandId}'},
          "model": {"stringValue": motorbike.model},
          "price": {"numberValue": motorbike.price},
          "images": {"arrayValue": motorbike.images}
        }
      }),
    );

    if (response.statusCode == 201) {
      motorbike.id = jsonDecode(response.body)['name'].split('/').last;
      _motorbikes.add(motorbike);
      notifyListeners();
    } else {
      throw Exception('Failed to create motorbike');
    }
  }

  Future<Motorbike?> readMotorbike(String motorbikeId) async {
    final response = await http.get(
      Uri.parse('$_baseUrlDb/motorbike/$motorbikeId'),
    );

    if (response.statusCode == 200) {
      var fields = jsonDecode(response.body)['fields'];
      return Motorbike(
          brandId: fields['brandId'],
          images: fields['images'],
          model: fields['model'],
          price: fields['price']);
    } else {
      return null;
    }
  }

  Future<void> updateMotorbike(
      String motorbikeId, Motorbike updatedMotorbike) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrlDb/motorbike/$motorbikeId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "fields": {
            "brandId": {"referenceValue": 'brand/${updatedMotorbike.brandId}'},
            "model": {"stringValue": updatedMotorbike.model},
            "price": {"numberValue": updatedMotorbike.price},
            "images": {"arrayValue": updatedMotorbike.images}
          }
        }),
      );

      if (response.statusCode == 200) {
        final index =
            _motorbikes.indexWhere((element) => element.id == motorbikeId);
        if (index != -1) {
          _motorbikes[index] = updatedMotorbike;
          notifyListeners();
        }
      }
    } catch (e) {
      throw Exception('Error occurred while updating motorbike: $e');
    }
  }

  Future<void> deleteMotorbike(String motorbikeId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrlDb/motorbike/$motorbikeId'),
      );

      if (response.statusCode == 204) {
        final index =
            _motorbikes.indexWhere((element) => element.id == motorbikeId);
        if (index != -1) {
          final motorbike = _motorbikes[index];
          _motorbikes.remove(motorbike);
          notifyListeners();
        }
      }
    } catch (e) {
      throw Exception('Error occurred while deleting motorbike: $e');
    }
  }
}
