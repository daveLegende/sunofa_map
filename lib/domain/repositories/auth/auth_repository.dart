import 'package:dartz/dartz.dart';
import 'package:sunofa_map/data/models/auth/login.dto.dart';
import 'package:sunofa_map/data/models/user/user.dto.dart';

abstract class AuthRepository {
  Future<Either> login(LoginDTO data);
  Future<Either> register(UserDTO data);
}