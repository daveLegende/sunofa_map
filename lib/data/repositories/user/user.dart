// import 'package:dartz/dartz.dart';
// import 'package:tournoi_zemoz/features/data/models/coupon/coupon.dto.dart';
// import 'package:tournoi_zemoz/features/data/models/user/changepass.dto.dart';
// import 'package:tournoi_zemoz/features/data/models/user/delete_bet_ticket.dto.dart';
// import 'package:tournoi_zemoz/features/data/models/user/update_user.dto.dart';
// import 'package:tournoi_zemoz/features/data/sources/user/user_service.dart';
// import 'package:tournoi_zemoz/features/domain/repositories/user/user_repository.dart';
// import 'package:tournoi_zemoz/service_locator.dart';

// class UserRepositoryImpl extends UserRepository {

//   @override
//   Future<Either> getCurrentUser() async {
//     return await sl<UserService>().getCurrentUser();
//   }

//   @override
//   Future<Either> changePass(ChangePassDTO data) async {
//     return await sl<UserService>().changePass(data);
//   }
  
//   @override
//   Future<Either> getUserTickets() async {
//     return await sl<UserService>().getUserTickets();
//   }

//   @override
//   Future<Either> getUserBets() async {
//     return await sl<UserService>().getUserBets();
//   }

//   @override
//   Future<Either> deleteUserBet(DeleteBetTicketDTO data) async {
//     return await sl<UserService>().deleteUserBet(data);
//   }

//   @override
//   Future<Either> deleteUserTicket(DeleteBetTicketDTO data) async {
//     return await sl<UserService>().deleteUserTicket(data);
//   }

//   @override
//   Future<Either> editUser(UpdateUserDTO data) async {
//     return await sl<UserService>().editUser(data);
//   }

//   @override
//   Future<Either> parier(CouponDTO data) async {
//     return await sl<UserService>().parier(data);
//   }
// }
