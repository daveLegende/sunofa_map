import 'package:sunofa_map/data/models/adresses/adresse.dto.dart';
import 'package:sunofa_map/domain/usecases/adresses/create_adresse.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_adresse_state.dart';

class CreateAdresseCubit extends Cubit<CreateAdresseState> {
  CreateAdresseCubit() : super(CreateAdresseLoadingState());

  Future<void> createAdresse(AdresseDTO data) async {
    var adresses = await sl<CreateAdresseUseCase>().call(params: data);

    adresses.fold(
      (l) => emit(CreateAdresseFailedState(message: l)),
      (r) => emit(CreateAdresseSuccessState(message: r)),
    );
  }
}
