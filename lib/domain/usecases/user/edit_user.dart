import 'package:dartz/dartz.dart';
import 'package:sunofa_map/core/usecases/usecase.dart';
import 'package:sunofa_map/data/models/user/user.dto.dart';
import 'package:sunofa_map/domain/repositories/user/user_repository.dart';
import 'package:sunofa_map/service_locator.dart';

class UpdateUserUseCase implements UseCase<Either, UserDTO> {

  @override
  Future<Either> call({UserDTO? params}) async {
    return sl<UserRepository>().editUser(params!);
  }

}
