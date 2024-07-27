import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:motorbikes_rent/models/brand.dart';
import 'package:motorbikes_rent/utils/api/brand.dart';

class BrandProvider with ChangeNotifier {
  final _brandApi = BrandApi();
  List<BrandModel> _brands = [];

  BrandProvider();

  List<BrandModel> get brands => [..._brands];

  BrandModel? findBrand(String brandId) {
    try {
      var brand = _brands.firstWhere((element) => element.id == brandId);
      return brand;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> loadBrands() async {
    final response = await _brandApi.loadBrands();
    _brands = response;
  }

  Future<BrandModel?> readBrand(String brandId) async {
    return BrandApi().readBrand(brandId);
  }
}
