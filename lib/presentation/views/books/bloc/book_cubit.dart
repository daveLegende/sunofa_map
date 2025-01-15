import 'package:sunofa_map/domain/usecases/adresseBook/adresse_book.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(BookLoadingState());

  Future<void> getBooks() async {
    var books = await sl<AdresseBookUseCase>().call();

    books.fold(
      (l) => emit(BookFailedState(message: l)),
      (r) => emit(BookSuccessState(books: r)),
    );
  }
}
