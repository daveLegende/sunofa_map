

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/domain/usecases/notifications/pin_send.dart';
import 'package:sunofa_map/service_locator.dart';

import 'send_pin_state.dart';

class SendPinCubit extends Cubit<SendPinState> {
  SendPinCubit() : super(SendPinLoadingState());

  Future<void> sendPin(IdParms? data) async {
    var fav = await sl<SendPinUseCase>().call(params: data);

    fav.fold(
      (l) => emit(SendPinFailedState(message: l)),
      (r) => emit(SendPinSuccessState(adresse: r)),
    );
  }
}
