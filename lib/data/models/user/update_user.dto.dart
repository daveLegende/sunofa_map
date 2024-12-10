class UpdateUserDTO {
  String id;
  String firstname;
  String lastname;
  String email;
  String phone;
  String? avatar;

  UpdateUserDTO({
    required this.id,
    required this.firstname,
    required this.phone,
    required this.lastname,
    required this.email,
    this.avatar,
  });

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'avatar': avatar,
    };
  }
}