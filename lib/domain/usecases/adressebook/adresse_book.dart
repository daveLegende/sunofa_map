// import 'package:dartz/dartz.dart';
// import 'package:tournoi_zemoz/core/usecases/usecase.dart';
// import 'package:tournoi_zemoz/features/data/models/forgotpass/forgotpass.dto.dart';
// import 'package:tournoi_zemoz/features/domain/repositories/forgotpass/forgotpass_repository.dart';
// import 'package:tournoi_zemoz/service_locator.dart';

// class SendMailUseCase implements UseCase<Either, ForgotPassDTO> {

//   @override
//   Future<Either> call({ForgotPassDTO? params}) async {
//     return sl<ForgotPassRepository>().sendEmail(params!);
//   }

// }


// class VerifyCodeUseCase implements UseCase<Either, ForgotPassDTO> {

//   @override
//   Future<Either> call({ForgotPassDTO? params}) async {
//     return sl<ForgotPassRepository>().verifyCode(params!);
//   }

// }


// class ReinitialisePassUseCase implements UseCase<Either, ReinitialisePassDTO> {

//   @override
//   Future<Either> call({ReinitialisePassDTO? params}) async {
//     return sl<ForgotPassRepository>().changePass(params!);
//   }

// }
