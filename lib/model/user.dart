class User {
  final String token;
  final String name;
  final String email;
  final String phoneNumber;
  String image;
  final String city;

  User(
      {required this.token,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.image,
      required this.city});
}
