class CustomerModel {
  String? id;
  String name;
  String email;
  String? profileImage;

  CustomerModel(
      {required this.name, required this.email, this.id, this.profileImage});
}
