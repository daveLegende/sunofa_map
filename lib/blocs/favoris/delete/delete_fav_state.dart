abstract class DeleteFavoriesState {}


class DeleteFavoriesLoadingState extends DeleteFavoriesState {}

class DeleteFavoriesSuccessState extends DeleteFavoriesState {
  final String message;

  DeleteFavoriesSuccessState({
    required this.message,
  });
}

class DeleteFavoriesFailedState extends DeleteFavoriesState {
  final String message;

  DeleteFavoriesFailedState({
    required this.message,
  });
}
