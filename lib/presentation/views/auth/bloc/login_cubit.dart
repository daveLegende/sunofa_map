import 'package:sunofa_map/data/models/auth/login.dto.dart';
import 'package:sunofa_map/domain/usecases/auth/login.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginLoadingState());

  Future<void> login(LoginDTO data) async {
    var login = await sl<LoginUseCase>().call(params: data);

    login.fold(
      (l) => emit(LoginFailedState(message: l)),
      (r) => emit(LoginSuccessState()),
    );
  }
}
