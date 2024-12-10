import 'package:sunofa_map/data/models/user/user.dto.dart';
import 'package:sunofa_map/domain/usecases/auth/register_user.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterLoadingState());

  Future<void> register(UserDTO data) async {
    var register = await sl<RegisterUserUseCase>().call(params: data);

    register.fold(
      (l) => emit(RegisterFailedState(message: l)),
      (r) => emit(RegisterSuccessState()),
    );
  }
}
