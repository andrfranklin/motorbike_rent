class MotorbikeModel {
  String? id;
  String brandId;
  String model;
  double price;
  double rentalPrice;
  List<String> images;

  MotorbikeModel(
      {required this.brandId,
      required this.model,
      required this.images,
      required this.price,
      this.id})
      : rentalPrice = price * 0.1;

  set newRentalTax(double newTax) => rentalPrice = price * newTax;
}
