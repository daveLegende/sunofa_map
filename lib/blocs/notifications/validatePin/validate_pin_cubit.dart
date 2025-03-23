import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/domain/usecases/notifications/validate_pin.dart';
import 'package:sunofa_map/service_locator.dart';

import 'validate_pin_state.dart';

class ValidatePinCubit extends Cubit<ValidatePinState> {
  ValidatePinCubit() : super(ValidatePinLoadingState());

  Future<void>validatePin(FullPin data) async {
    var adresses = await sl<ValidatePinUseCase>().call(params: data);

    adresses.fold(
      (l) => emit(ValidatePinFailedState(message: l)),
      (r) => emit(ValidatePinSuccessState(message: r)),
    );
  }
}
