abstract class DeleteBookState {}


class DeleteBookLoadingState extends DeleteBookState {}

class DeleteBookSuccessState extends DeleteBookState {
  final bool isDelete;

  DeleteBookSuccessState({
    required this.isDelete,
  });
}

class DeleteBookFailedState extends DeleteBookState {
  final String message;

  DeleteBookFailedState({
    required this.message,
  });
}
