class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String idImagePath;
  final String licenceImagePath;


  UserModel(
      this.idImagePath, this.licenceImagePath,
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      });
}
