import 'package:get_it/get_it.dart';
import 'package:sunofa_map/data/repositories/adresses/adresses.dart';
import 'package:sunofa_map/data/repositories/auth/auth.repository.dart';
import 'package:sunofa_map/data/sources/adresses/adresses_service.dart';
import 'package:sunofa_map/data/sources/auth/auth_service.dart';
import 'package:sunofa_map/domain/repositories/adresses/adresse_repo.dart';
import 'package:sunofa_map/domain/repositories/auth/auth_repository.dart';
import 'package:sunofa_map/domain/usecases/adresses/adresses.dart';
import 'package:sunofa_map/domain/usecases/auth/login.dart';
import 'package:sunofa_map/domain/usecases/auth/register_user.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  /**
   * Auth
  */
  sl.registerSingleton<AuthService>(
    AuthServiceImpl(),
  );
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(),
  );

  sl.registerSingleton<LoginUseCase>(
    LoginUseCase(),
  );
  sl.registerSingleton<RegisterUserUseCase>(
    RegisterUserUseCase(),
  );

  /***
   * Adresses
  */
  sl.registerSingleton<AdresseUseCase>(
    AdresseUseCase(),
  );
  sl.registerSingleton<AdresseService>(
    AdresseServiceImpl(),
  );
  sl.registerSingleton<AdresseRepository>(
    AdresseRepositoryImpl(),
  );

  // /***
  //  * match
  // */
  // sl.registerSingleton<MatchService>(
  //   MatchServiceImpl(),
  // );
  // sl.registerSingleton<MatchRepository>(
  //   MatchRepositoryImpl(),
  // );
  // sl.registerSingleton<MatchUseCase>(
  //   MatchUseCase(),
  // );

  // /***
  //  * Poule
  // */
  // sl.registerSingleton<PouleService>(
  //   PouleServiceImpl(),
  // );
  // sl.registerSingleton<PouleRepository>(
  //   PouleRepositoryImpl(),
  // );
  // sl.registerSingleton<PouleUseCase>(
  //   PouleUseCase(),
  // );

  // /***
  //  * Tickets
  // */
  // sl.registerSingleton<TicketService>(
  //   TicketServiceImpl(),
  // );
  // sl.registerSingleton<TicketRepository>(
  //   TicketRepositoryImpl(),
  // );
  // sl.registerSingleton<TicketUseCase>(
  //   TicketUseCase(),
  // );
  // sl.registerSingleton<BuyTicketUseCase>(
  //   BuyTicketUseCase(),
  // );

  // /***
  //  * User
  // */
  // sl.registerSingleton<UserService>(
  //   UserServiceImpl(),
  // );
  // sl.registerSingleton<UserRepository>(
  //   UserRepositoryImpl(),
  // );
  // sl.registerSingleton<UserUseCase>(
  //   UserUseCase(),
  // );
  // sl.registerSingleton<UserTicketsUseCase>(
  //   UserTicketsUseCase(),
  // );
  // sl.registerSingleton<UserBetsUseCase>(
  //   UserBetsUseCase(),
  // );
  // sl.registerSingleton<DeleteBetUseCase>(
  //   DeleteBetUseCase(),
  // );
  // sl.registerSingleton<DeleteTicketUseCase>(
  //   DeleteTicketUseCase(),
  // );
  // sl.registerSingleton<ChangePassUseCase>(
  //   ChangePassUseCase(),
  // );
  // sl.registerSingleton<EditUserUseCase>(
  //   EditUserUseCase(),
  // );
  // sl.registerSingleton<ParierUseCase>(
  //   ParierUseCase(),
  // );

  // /***
  //  * Coupon
  // */
  // sl.registerSingleton<CouponService>(
  //   CouponServiceImpl(),
  // );
  // sl.registerSingleton<CouponRepository>(
  //   CouponRepositoryImpl(),
  // );
  // sl.registerSingleton<CouponUseCase>(
  //   CouponUseCase(),
  // );

  // /***
  //  * Transaction
  // */
  // sl.registerSingleton<TransactionService>(
  //   TransactionServiceImpl(),
  // );
  // sl.registerSingleton<TransactionRepository>(
  //   TransactionRepositoryImpl(),
  // );
  // sl.registerSingleton<TransactionUseCase>(
  //   TransactionUseCase(),
  // );


  // /***
  //  * forgot pass
  // */
  // sl.registerSingleton<ForgotPassService>(
  //   ForgotPassServiceImpl(),
  // );
  // sl.registerSingleton<ForgotPassRepository>(
  //   ForgotPassRepositoryImpl(),
  // );
  // sl.registerSingleton<SendMailUseCase>(
  //   SendMailUseCase(),
  // );
  // sl.registerSingleton<VerifyCodeUseCase>(
  //   VerifyCodeUseCase(),
  // );
  // sl.registerSingleton<ReinitialisePassUseCase>(
  //   ReinitialisePassUseCase(),
  // );
}
