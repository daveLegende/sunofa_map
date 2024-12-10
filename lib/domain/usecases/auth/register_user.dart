import 'package:dartz/dartz.dart';
import 'package:sunofa_map/core/usecases/usecase.dart';
import 'package:sunofa_map/data/models/user/user.dto.dart';
import 'package:sunofa_map/domain/repositories/auth/auth_repository.dart';
import 'package:sunofa_map/service_locator.dart';

class RegisterUserUseCase implements UseCase<Either, UserDTO> {

  @override
  Future<Either> call({UserDTO? params}) async {
    return sl<AuthRepository>().register(params!);
  }

}
