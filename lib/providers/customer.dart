import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:motorbikes_rent/models/customer.dart';
import 'package:motorbikes_rent/utils/api/customer.dart';

class CustomerProvider with ChangeNotifier {
  CustomerModel? _customer;
  final _customerApi = CustomerApi();

  CustomerProvider();

  CustomerModel? get customer => _customer;

  Future<void> signIn({required String email, required String password}) async {
    final customer =
        await _customerApi.signIn(email: email, password: password);
    _customer = customer;
    notifyListeners();
  }

  Future<void> signUp(CustomerModel customer, String password) async {
    final response = await _customerApi.signUp(customer, password);
    _customer = response;
    notifyListeners();
  }

  void signOut() {
    _customer = null;
    notifyListeners();
  }

  Future<void> update(String customerId, CustomerModel updatedCustomer) async {
    final response = await _customerApi.update(
        customerId: customerId, updatedCustomer: updatedCustomer);
    _customer = response;
    notifyListeners();
  }

  Future<void> deleteAccount(String password) async {
    if (_customer?.id != null) {
      await _customerApi.deleteAccount(customerId: _customer?.id ?? "");
      _customer = null;
      notifyListeners();
    }
  }
}
