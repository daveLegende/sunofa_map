abstract class DeleteAdresseState {}


class DeleteAdresseLoadingState extends DeleteAdresseState {}

class DeleteAdresseSuccessState extends DeleteAdresseState {
  final bool isDelete;

  DeleteAdresseSuccessState({
    required this.isDelete,
  });
}

class DeleteAdresseFailedState extends DeleteAdresseState {
  final String message;

  DeleteAdresseFailedState({
    required this.message,
  });
}
