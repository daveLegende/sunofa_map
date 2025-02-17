import 'package:sunofa_map/data/models/adressebook/adresse_book.dto.dart';
import 'package:sunofa_map/domain/usecases/adresseBook/edit_adresse_book.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_state.dart';

class EditBookCubit extends Cubit<EditBookState> {
  EditBookCubit() : super(EditBookLoadingState());

  Future<void> editBook(AdresseBookDTO data) async {
    var books = await sl<EditAdresseBookUseCase>().call(params: data);

    books.fold(
      (l) => emit(EditBookFailedState(message: l)),
      (r) => emit(EditBookSuccessState(message: r)),
    );
  }
}
