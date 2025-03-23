

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunofa_map/domain/usecases/favories/favories.dart';
import 'package:sunofa_map/service_locator.dart';

import 'favories_state.dart';

class FavoriesCubit extends Cubit<FavoriesState> {
  FavoriesCubit() : super(FavoriesLoadingState());

  Future<void> getFavories() async {
    var fav = await sl<FavorisUseCase>().call();

    fav.fold(
      (l) => emit(FavoriesFailedState(message: l)),
      (r) => emit(FavoriesSuccessState(favoris: r)),
    );
  }
}
