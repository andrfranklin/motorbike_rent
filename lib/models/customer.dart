import 'package:motorbikes_rent/models/address.dart';

class Customer {
  String name;
  String cpf;
  int age;
  Address address;

  Customer(this.name, this.cpf, this.age, this.address);
}
