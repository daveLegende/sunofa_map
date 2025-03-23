

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/domain/usecases/favories/delete_favoris.dart';
import 'package:sunofa_map/service_locator.dart';

import 'delete_fav_state.dart';

class DeleteFavoriesCubit extends Cubit<DeleteFavoriesState> {
  DeleteFavoriesCubit() : super(DeleteFavoriesLoadingState());

  Future<void> deleteFavories(IdParms data) async {
    var notes = await sl<DeleteFavorisUseCase>().call(params: data);

    notes.fold(
      (l) => emit(DeleteFavoriesFailedState(message: l)),
      (r) => emit(DeleteFavoriesSuccessState(message: r)),
    );
  }
}
