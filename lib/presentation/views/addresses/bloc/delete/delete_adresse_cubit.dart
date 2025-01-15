import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/domain/usecases/adresses/delete_adresse.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delete_adresse_state.dart';

class DeleteAdresseCubit extends Cubit<DeleteAdresseState> {
  DeleteAdresseCubit() : super(DeleteAdresseLoadingState());

  Future<void> deleteAdresse(IdParms data) async {
    var adresses = await sl<DeleteAdresseUseCase>().call(params: data);

    adresses.fold(
      (l) => emit(DeleteAdresseFailedState(message: l)),
      (r) => emit(DeleteAdresseSuccessState(isDelete: r)),
    );
  }
}
