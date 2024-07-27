import 'dart:convert';

import 'package:motorbikes_rent/models/customer.dart';
import 'package:motorbikes_rent/utils/base_url.dart';
import 'package:http/http.dart' as http;

class CustomerApi {
  final _baseUrlDb = '${BaseUrl.db}/user';

  Future<CustomerModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrlDb.json?orderBy="email"&equalTo="$email"'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String customerId = data.keys.first;
      if (data[customerId]['password'] == password) {
        return CustomerModel(
          name: data[customerId]['name'],
          email: data[customerId]['email'],
          id: customerId,
        );
      } else {
        throw Exception('Wrong password');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to sign in customer');
    }
  }

  Future<CustomerModel> signUp(CustomerModel customer, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrlDb.json'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "name": customer.name,
          "email": customer.email,
          "password": password
        }),
      );
      customer.id = jsonDecode(response.body)['name'];
      return customer;
    } catch (e) {
      print(e);
      throw Exception('Failed to create customer');
    }
  }

  Future<CustomerModel> update({
    required String customerId,
    required CustomerModel updatedCustomer,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrlDb/$customerId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "fields": {
            "name": {"stringValue": updatedCustomer.name},
            "email": {"stringValue": updatedCustomer.email},
          }
        }),
      );

      if (response.statusCode != 200) {
        throw Exception("customer not updated");
      }
      return updatedCustomer;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<String> deleteAccount({required String customerId}) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrlDb/$customerId'),
      );

      if (response.statusCode != 204) {
        throw Exception('Failed to delete customer');
      }
      return customerId;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
