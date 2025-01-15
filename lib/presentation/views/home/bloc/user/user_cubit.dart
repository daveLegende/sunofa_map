import 'package:sunofa_map/domain/usecases/user/user.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserLoadingState());

  Future<void> getCurrentUser() async {
    var user = await sl<UserUseCase>().call();
    // print(user);

    user.fold(
      (l) => emit(UserFailedState(message: l)),
      (r) => emit(UserSuccessState(user: r)),
    );
  }
}
