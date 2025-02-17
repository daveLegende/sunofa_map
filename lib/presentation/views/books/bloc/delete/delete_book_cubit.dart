import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/domain/usecases/adresseBook/delete_adresse_book.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delete_book_state.dart';

class DeleteBookCubit extends Cubit<DeleteBookState> {
  DeleteBookCubit() : super(DeleteBookLoadingState());

  Future<void> deleteBook(IdParms data) async {
    var book = await sl<DeleteAdresseBookUseCase>().call(params: data);

    book.fold(
      (l) => emit(DeleteBookFailedState(message: l)),
      (r) => emit(DeleteBookSuccessState(isDelete: r)),
    );
  }
}
