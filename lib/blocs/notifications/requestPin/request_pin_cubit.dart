

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/domain/usecases/notifications/request_pin.dart';
import 'package:sunofa_map/service_locator.dart';

import 'request_pin_state.dart';

class RequestPinCubit extends Cubit<RequestPinState> {
  RequestPinCubit() : super(RequestPinLoadingState());

  Future<void> requestPin(IdParms data) async {
    var notes = await sl<RequestPinUseCase>().call(params: data);

    notes.fold(
      (l) => emit(RequestPinFailedState(message: l)),
      (r) => emit(RequestPinSuccessState(notification: r)),
    );
  }
}
