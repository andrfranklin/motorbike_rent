import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:motorbikes_rent/models/customer.dart';
import 'package:motorbikes_rent/utils/base_url.dart';

class CustomerProvider with ChangeNotifier {
  Customer? _customer;
  final String _baseUrlDb = '${BaseUrl.db}/user';

  CustomerProvider();

  Customer? get customer => _customer;

  Future<void> signInCustomer(String email, String password) async {
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
        _customer = Customer(
            name: data[customerId]['name'],
            email: data[customerId]['email'],
            id: customerId);
        notifyListeners();
      } else {
        throw Exception('Wrong password');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to sign in customer');
    }
  }

  Future<void> signUpCustomer(Customer customer, String password) async {
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
      _customer = customer;
      notifyListeners();
    } catch (e) {
      print(e);
      throw Exception('Failed to create customer');
    }
  }

  void signOut() {
    _customer = null;
    notifyListeners();
  }

  Future<void> updateCustomer(
      String customerId, Customer updatedCustomer) async {
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

      if (response.statusCode == 200) {
        _customer = updatedCustomer;
      }
    } catch (e) {
      throw Exception('Failed to update customer');
    }
    notifyListeners();
  }

  Future<void> deleteCustomer(String customerId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrlDb/$customerId'),
      );

      if (response.statusCode == 204) {
        _customer = null;
      }
    } catch (e) {
      throw Exception('Failed to delete customer');
    }
    notifyListeners();
  }

  Future<void> rent(String motorbikeId, int months) async {
    try {
      await http.post(
        Uri.parse('$_baseUrlDb/${customer?.id}/rented.json'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"motorbikeId": motorbikeId, "months": months}),
      );
    } catch (e) {
      print(e);
      throw Exception('Failed to sign in customer');
    }
  }
}
