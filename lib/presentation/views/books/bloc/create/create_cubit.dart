import 'package:sunofa_map/data/models/adressebook/adresse_book.dto.dart';
import 'package:sunofa_map/domain/usecases/adresseBook/create_adresse_book.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_state.dart';

class CreateBookCubit extends Cubit<CreateBookState> {
  CreateBookCubit() : super(CreateBookLoadingState());

  Future<void> createBooks(AdresseBookDTO data) async {
    var books = await sl<CreateAdresseBookUseCase>().call(params: data);

    books.fold(
      (l) => emit(CreateBookFailedState(message: l)),
      (r) => emit(CreateBookSuccessState(message: r)),
    );
  }
}
