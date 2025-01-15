import 'package:dartz/dartz.dart';
import 'package:sunofa_map/data/models/user/user.dto.dart';

abstract class UserRepository {
  Future<Either> getCurrentUser();
  Future<Either> editUser(UserDTO data);
  Future<Either> changePass(UserDTO data);
}
