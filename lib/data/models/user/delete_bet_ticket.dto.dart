
class DeleteBetTicketDTO {
  final String id;
  final String userId;


  const DeleteBetTicketDTO({
    required this.id,
    required this.userId,
  });

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
    };
  }

}