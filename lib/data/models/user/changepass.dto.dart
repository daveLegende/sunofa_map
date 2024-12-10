class ChangePassDTO {
  final String id; // user id
  final String oldpass;
  final String newpass;
  final String confirm;

  const ChangePassDTO({
    required this.id,
    required this.oldpass,
    required this.newpass,
    required this.confirm,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "oldpass": oldpass,
      "newpass": newpass,
      "confirm": confirm,
    };
  }
}
