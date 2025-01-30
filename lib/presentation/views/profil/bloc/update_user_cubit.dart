import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunofa_map/data/models/user/user.dto.dart';
import 'package:sunofa_map/domain/usecases/user/edit_user.dart';
import 'package:sunofa_map/service_locator.dart';

import 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit() : super(UpdateUserLoadingState());

  Future<void> updateUser(UserDTO data) async {
    var adresses = await sl<UpdateUserUseCase>().call(params: data);

    adresses.fold(
      (l) => emit(UpdateUserFailedState(message: l)),
      (r) => emit(UpdateUserSuccessState(message: r)),
    );
  }
}
