import 'package:dartz/dartz.dart';
import 'package:sunofa_map/core/usecases/usecase.dart';
import 'package:sunofa_map/data/models/auth/login.dto.dart';
import 'package:sunofa_map/domain/repositories/auth/auth_repository.dart';
import 'package:sunofa_map/service_locator.dart';

class LoginUseCase implements UseCase<Either, LoginDTO> {

  @override
  Future<Either> call({LoginDTO? params}) async {
    return sl<AuthRepository>().login(params!);
  }

}
