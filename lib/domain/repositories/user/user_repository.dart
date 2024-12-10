import 'package:dartz/dartz.dart';
import 'package:sunofa_map/data/models/user/user.dto.dart';

abstract class UserRepository {
  Future<Either> getCurrentUser();
  Future<Either> getUserTickets();
  Future<Either> getUserBets();
  Future<Either> editUser(UserDTO data);
  Future<Either> changePass(UserDTO data);
  // Future<Either> deleteUserBet(UserDTO data);
  // Future<Either> deleteUserTicket(DeleteBetTicketDTO data);
  // Future<Either> parier(CouponDTO data);
}
