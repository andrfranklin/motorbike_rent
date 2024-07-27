import 'dart:convert';

import 'package:motorbikes_rent/models/brand.dart';
import 'package:motorbikes_rent/utils/base_url.dart';
import 'package:http/http.dart' as http;

class BrandApi {
  final String _baseUrlDb = '${BaseUrl.db}/brands';
  final String _baseUrlStorage = '${BaseUrl.storage}brand%2F';

  Future<List<BrandModel>> loadBrands({int? page, int? limit}) async {
    final List<BrandModel> brands = [];
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
        final name = data[id]['name'];
        final logo = data[id]['logo'];
        if (brands.any((element) => element == id)) return;
        brands.add(BrandModel(name: name, logo: logo, id: id));
      });
      return brands;
    } catch (e) {
      print(e);
      throw Exception('Failed to load brand');
    }
  }

  Future<BrandModel?> readBrand(String brandId) async {
    final response = await http.get(
      Uri.parse('$_baseUrlDb/$brandId'),
    );

    if (response.statusCode == 200) {
      var fields = jsonDecode(response.body)['fields'];
      return BrandModel(name: fields['name'], logo: fields['logo']);
    } else {
      return null;
    }
  }

  String imageUrl(String imageName) {
    return '$_baseUrlStorage$imageName?alt=media';
  }
}
