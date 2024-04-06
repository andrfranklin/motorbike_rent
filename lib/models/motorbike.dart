import 'package:motorbikes_rent/models/brand.dart';

class Motorbike {
  Brand brand;
  String model;
  double price;
  double rentalPrice;
  List<String>? images;

  Motorbike(
      {required this.brand,
      required this.model,
      this.images,
      required this.price})
      : rentalPrice = price * 0.1;

  set newRentalTax(double newTax) => rentalPrice = price * newTax;
}
