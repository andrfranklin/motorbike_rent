import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:motorbikes_rent/models/motorbike.dart';
import 'package:motorbikes_rent/models/rental.dart';
import 'package:motorbikes_rent/utils/base_url.dart';

class RentApi {
  final _baseUrlDb = '${BaseUrl.db}/rental';

  Future<void> rent({
    required MotorbikeModel motorbikeModel,
    required String customerId,
    required int months,
  }) async {
    try {
      final startDate = DateTime.now().toIso8601String();
      final endDate =
          DateTime.now().add(Duration(days: (months * 30))).toIso8601String();
      await http.post(
        Uri.parse('$_baseUrlDb/$customerId.json'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "motorbikeId": motorbikeModel.id,
          "startDate": startDate,
          "endDate": endDate,
          "price": motorbikeModel.price
        }),
      );
    } catch (e) {
      print(e);
      throw Exception('Failed to add a new rental for customer');
    }
  }

  Future<List<RentalModel>> getRent({
    required String customerId,
    bool? active,
  }) async {
    List<RentalModel> rentals = [];
    try {
      final response = await http.get(
        Uri.parse('$_baseUrlDb/$customerId.json'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final Map<String, dynamic> data = jsonDecode(response.body);
      data.forEach((key, value) {
        rentals.add(RentalModel(
            id: key,
            productId: value["motorbikeId"],
            startDate: value["startDate"],
            endDate: value["endDate"],
            price: value["price"]));
      });

      return rentals;
    } catch (e) {
      print(e);
      throw Exception('Failed to get customer rental data');
    }
  }

  Future<int> getCountRental({
    required String customerId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrlDb/$customerId.json'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final Map<String, dynamic> data = jsonDecode(response.body);
      return data.length;
    } catch (e) {
      print(e);
      throw Exception('Failed to get the amount of customer rental');
    }
  }
}
