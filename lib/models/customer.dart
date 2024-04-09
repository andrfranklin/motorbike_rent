import 'package:motorbikes_rent/models/address.dart';

class Customer {
  String name;
  String cpf;
  DateTime birthDate;
  Address address;

  Customer(this.name, this.cpf, this.birthDate, this.address);
}
