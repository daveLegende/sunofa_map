import 'package:dartz/dartz.dart';
import 'package:sunofa_map/data/models/auth/login.dto.dart';
import 'package:sunofa_map/data/models/user/user.dto.dart';
import 'package:sunofa_map/data/sources/auth/auth_service.dart';
import 'package:sunofa_map/domain/repositories/auth/auth_repository.dart';
import 'package:sunofa_map/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> login(LoginDTO data) async {
    return await sl<AuthService>().login(data);
  }

  @override
  Future<Either> register(UserDTO data) async {
    return await sl<AuthService>().register(data);
  }
}
