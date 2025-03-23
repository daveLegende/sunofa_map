import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunofa_map/data/models/favories/favories.dto.dart';
import 'package:sunofa_map/domain/usecases/favories/create_favoris.dart';
import 'package:sunofa_map/service_locator.dart';

import 'create_fav_state.dart';

class CreateFavoriesCubit extends Cubit<CreateFavoriesState> {
  CreateFavoriesCubit() : super(CreateFavoriesLoadingState());

  Future<void> createFavories(FavoriesDTO data) async {
    var adresses = await sl<CreateFavorisUseCase>().call(params: data);

    adresses.fold(
      (l) => emit(CreateFavoriesFailedState(message: l)),
      (r) => emit(CreateFavoriesSuccessState(message: r)),
    );
  }
}
