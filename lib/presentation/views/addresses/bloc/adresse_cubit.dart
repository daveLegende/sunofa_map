import 'package:sunofa_map/domain/usecases/adresses/adresses.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'adresse_state.dart';

class AdresseCubit extends Cubit<AdresseState> {
  AdresseCubit() : super(AdresseLoadingState());

  Future<void> getAdresses() async {
    var adresses = await sl<AdresseUseCase>().call();

    adresses.fold(
      (l) => emit(AdresseFailedState(message: l)),
      (r) => emit(AdresseSuccessState(adresses: r)),
    );
  }
}
