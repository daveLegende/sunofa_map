import 'package:dartz/dartz.dart';
import 'package:sunofa_map/data/models/user/user.dto.dart';
import 'package:sunofa_map/data/sources/user/user.service.dart';
import 'package:sunofa_map/domain/repositories/user/user_repository.dart';
import 'package:sunofa_map/service_locator.dart';

class UserRepositoryImpl extends UserRepository {

  @override
  Future<Either> getCurrentUser() async {
    return await sl<UserService>().getCurrentUser();
  }

  @override
  Future<Either> changePass(UserDTO data) async {
    return await sl<UserService>().changePass(data);
  }
  

  @override
  Future<Either> editUser(UserDTO data) async {
    return await sl<UserService>().editUser(data);
  }
}
