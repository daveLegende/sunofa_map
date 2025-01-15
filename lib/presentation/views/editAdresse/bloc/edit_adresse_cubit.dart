import 'package:sunofa_map/data/models/adresses/adresse.dto.dart';
import 'package:sunofa_map/domain/usecases/adresses/edit_adresse.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_adresse_state.dart';

class EditAdresseCubit extends Cubit<EditAdresseState> {
  EditAdresseCubit() : super(EditAdresseLoadingState());

  Future<void> editAdresse(AdresseDTO data) async {
    var adresses = await sl<EditAdresseUseCase>().call(params: data);

    adresses.fold(
      (l) => emit(EditAdresseFailedState(message: l)),
      (r) => emit(EditAdresseSuccessState(message: r)),
    );
  }
}
