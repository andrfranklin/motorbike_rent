class RentalModel {
  final String id;
  final String productId;
  final String startDate;
  final String endDate;
  final double price;

  RentalModel(
      {required this.id,
      required this.productId,
      required this.startDate,
      required this.endDate,
      required this.price});
}
