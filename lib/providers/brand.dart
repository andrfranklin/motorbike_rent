import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:motorbikes_rent/models/brand.dart';
import 'package:motorbikes_rent/utils/base_url.dart';

class BrandProvider with ChangeNotifier {
  final List<Brand> _brands = [];
  final String _baseUrlDb = '${BaseUrl.db}/brands';

  BrandProvider();

  List<Brand> get brands => _brands;

  Brand? findBrand(String id) {
    try {
      var brand = _brands.firstWhere((element) => element.id == id);
      return brand ?? Brand(name: '', logo: '');
    } catch (e) {
      print(e);
      return Brand(name: '', logo: '');
    }
  }

  Future<void> loadBrands() async {
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
        if (brands.any((element) => element?.id == id)) return;
        _brands.add(Brand(name: name, logo: logo, id: id));
      });
      notifyListeners();
    } catch (e) {
      print(e);
      throw Exception('Failed to load brand');
    }
  }

  Future<void> createBrand(Brand brand) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrlDb),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "fields": {
            "name": {"stringValue": brand.name},
            "logo": {"stringValue": "teste"}
          }
        }),
      );

      brand.id = jsonDecode(response.body)['name'].split('/').last;
      _brands.add(brand);
    } catch (e) {
      throw Exception('Failed to create brand');
    }

    notifyListeners();
  }

  Future<Brand?> readBrand(String brandId) async {
    final response = await http.get(
      Uri.parse('$_baseUrlDb/$brandId'),
    );

    if (response.statusCode == 200) {
      var fields = jsonDecode(response.body)['fields'];
      return Brand(name: fields['name'], logo: fields['logo']);
    } else {
      return null;
    }
  }

  Future<void> updateBrand(String brandId, Brand updatedBrand) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrlDb/$brandId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "fields": {
            "name": {"stringValue": updatedBrand.name},
            "logo": {"stringValue": updatedBrand.logo}
          }
        }),
      );

      if (response.statusCode == 200) {
        final index = _brands.indexWhere((element) => element.id == brandId);
        if (index != -1) {
          _brands[index] = updatedBrand;
          notifyListeners();
        }
      }
    } catch (e) {
      throw Exception('Failed to update brand');
    }
    notifyListeners();
  }

  Future<void> deleteBrand(String brandId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrlDb/$brandId'),
      );

      if (response.statusCode == 204) {
        for (var i = 0; i < _brands.length; i++) {
          if (_brands[i].id == brandId) {
            _brands.removeAt(i);
            return;
          }
        }
      }
    } catch (e) {
      throw Exception('Failed to delete brand');
    }
    notifyListeners();
  }
}
