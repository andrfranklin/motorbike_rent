import 'dart:convert';

import 'package:motorbikes_rent/models/motorbike.dart';
import 'package:motorbikes_rent/utils/base_url.dart';
import 'package:http/http.dart' as http;

class MotorbikeApi {
  final String _baseUrlDb = '${BaseUrl.db}/motorbike';
  final String _baseUrlStorage = '${BaseUrl.storage}motorbike%2F';

  Future<List<MotorbikeModel>> loadMotorbike({int? page, int? limit}) async {
    try {
      final List<MotorbikeModel> motorbikes = [];
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
        if (motorbikes.any((element) => element.id == id)) return;
        motorbikes.add(MotorbikeModel(
            brandId: brandId,
            model: model,
            images: images,
            price: price,
            id: id));
      });

      return motorbikes.toList();
    } catch (e) {
      print(e);
      throw Exception('Failed to load motorbikes');
    }
  }

  Future<MotorbikeModel?> readMotorbike({required String motorbikeId}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrlDb/$motorbikeId.json'),
      );

      if (response.statusCode == 200) {
        final fields = jsonDecode(response.body);
        return MotorbikeModel(
            brandId: fields['brandId'],
            images: List<String>.from(fields['images']),
            model: fields['model'],
            price: double.parse(fields['price'].toString()),
            id: motorbikeId);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load motorbike');
    }
  }

  String imageUrl(String imageName) {
    return '$_baseUrlStorage$imageName?alt=media';
  }
}
