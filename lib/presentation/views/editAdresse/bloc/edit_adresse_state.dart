abstract class EditAdresseState {}


class EditAdresseLoadingState extends EditAdresseState {}

class EditAdresseSuccessState extends EditAdresseState {
  final String message;

  EditAdresseSuccessState({
    required this.message,
  });
}

class EditAdresseFailedState extends EditAdresseState {
  final String message;

  EditAdresseFailedState({
    required this.message,
  });
}
