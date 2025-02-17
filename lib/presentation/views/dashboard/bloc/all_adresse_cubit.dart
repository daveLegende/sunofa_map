import 'package:sunofa_map/domain/usecases/adresses/adresses.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'all_adresse_state.dart';

class AllAdresseCubit extends Cubit<AllAdresseState> {
  AllAdresseCubit() : super(AllAdresseLoadingState());

  Future<void> getAllAdresses() async {
    var adresses = await sl<AllAdresseUseCase>().call();

    adresses.fold(
      (l) => emit(AllAdresseFailedState(message: l)),
      (r) => emit(AllAdresseSuccessState(adresses: r)),
    );
  }
}
