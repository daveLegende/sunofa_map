import 'package:get_it/get_it.dart';
import 'package:sunofa_map/data/repositories/adressebook/adresse_book.dart';
import 'package:sunofa_map/data/repositories/adresses/adresses.dart';
import 'package:sunofa_map/data/repositories/auth/auth.repository.dart';
import 'package:sunofa_map/data/repositories/favories/favories.dart';
import 'package:sunofa_map/data/repositories/notes/notes.dart';
import 'package:sunofa_map/data/repositories/notification/notification.dart';
// import 'package:sunofa_map/data/repositories/pin/pin.dart';
import 'package:sunofa_map/data/repositories/user/user.dart';
import 'package:sunofa_map/data/sources/adressebook/adresse_book.service.dart';
import 'package:sunofa_map/data/sources/adresses/adresses.service.dart';
import 'package:sunofa_map/data/sources/auth/auth.service.dart';
import 'package:sunofa_map/data/sources/favories/favories.service.dart';
import 'package:sunofa_map/data/sources/notes/notes.service.dart';
import 'package:sunofa_map/data/sources/notifications/notification.dart';
import 'package:sunofa_map/data/sources/pin/pin.service.dart';
import 'package:sunofa_map/data/sources/user/user.service.dart';
import 'package:sunofa_map/domain/repositories/adressebook/adresse_book_repo.dart';
import 'package:sunofa_map/domain/repositories/adresses/adresse_repo.dart';
import 'package:sunofa_map/domain/repositories/auth/auth_repository.dart';
import 'package:sunofa_map/domain/repositories/favories/favories_repository.dart';
import 'package:sunofa_map/domain/repositories/notes/notes_repository.dart';
import 'package:sunofa_map/domain/repositories/notifications/notification_repository.dart';
import 'package:sunofa_map/domain/repositories/pin/pin_repository.dart';
import 'package:sunofa_map/domain/repositories/user/user_repository.dart';
import 'package:sunofa_map/domain/usecases/adresseBook/adresse_book.dart';
import 'package:sunofa_map/domain/usecases/adresseBook/create_adresse_book.dart';
import 'package:sunofa_map/domain/usecases/adresseBook/delete_adresse_book.dart';
import 'package:sunofa_map/domain/usecases/adresseBook/edit_adresse_book.dart';
import 'package:sunofa_map/domain/usecases/adresses/adresses.dart';
import 'package:sunofa_map/domain/usecases/adresses/create_adresse.dart';
import 'package:sunofa_map/domain/usecases/adresses/delete_adresse.dart';
import 'package:sunofa_map/domain/usecases/adresses/edit_adresse.dart';
import 'package:sunofa_map/domain/usecases/auth/login.dart';
import 'package:sunofa_map/domain/usecases/auth/register_user.dart';
import 'package:sunofa_map/domain/usecases/favories/create_favoris.dart';
import 'package:sunofa_map/domain/usecases/favories/delete_favoris.dart';
import 'package:sunofa_map/domain/usecases/favories/favories.dart';
import 'package:sunofa_map/domain/usecases/notes/create_note.dart';
import 'package:sunofa_map/domain/usecases/notes/delete_note.dart';
import 'package:sunofa_map/domain/usecases/notes/edit_note.dart';
import 'package:sunofa_map/domain/usecases/notes/notes.dart';
import 'package:sunofa_map/domain/usecases/notifications/pin_send.dart';
import 'package:sunofa_map/domain/usecases/notifications/request_pin.dart';
import 'package:sunofa_map/domain/usecases/notifications/validate_pin.dart';
import 'package:sunofa_map/domain/usecases/user/edit_user.dart';
import 'package:sunofa_map/domain/usecases/user/user.dart';

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
  
  sl.registerSingleton<UpdateUserUseCase>(
    UpdateUserUseCase(),
  );

  /***
   * Adresses
  */
  sl.registerSingleton<AdresseService>(
    AdresseServiceImpl(),
  );
  sl.registerSingleton<AdresseRepository>(
    AdresseRepositoryImpl(),
  );
  sl.registerSingleton<AdresseUseCase>(
    AdresseUseCase(),
  );
  sl.registerSingleton<AllAdresseUseCase>(
    AllAdresseUseCase(),
  );
  sl.registerSingleton<CreateAdresseUseCase>(
    CreateAdresseUseCase(),
  );
  sl.registerSingleton<DeleteAdresseUseCase>(
    DeleteAdresseUseCase(),
  );
  sl.registerSingleton<EditAdresseUseCase>(
    EditAdresseUseCase(),
  );


  /***
   * Adresses Books
  */
  sl.registerSingleton<AdresseBookService>(
    AdresseBookServiceImpl(),
  );
  sl.registerSingleton<AdresseBookRepository>(
    AdresseBookRepositoryImpl(),
  );
  sl.registerSingleton<AdresseBookUseCase>(
    AdresseBookUseCase(),
  );
  sl.registerSingleton<CreateAdresseBookUseCase>(
    CreateAdresseBookUseCase(),
  );
  sl.registerSingleton<DeleteAdresseBookUseCase>(
    DeleteAdresseBookUseCase(),
  );
  sl.registerSingleton<EditAdresseBookUseCase>(
    EditAdresseBookUseCase(),
  );

  /***
   * Notes
  */
  sl.registerSingleton<NoteService>(
    NoteServiceImpl(),
  );
  sl.registerSingleton<NotesRepository>(
    NoteRepositoryImpl(),
  );
  sl.registerSingleton<NoteUseCase>(
    NoteUseCase(),
  );
  sl.registerSingleton<CreateNoteUseCase>(
    CreateNoteUseCase(),
  );
  sl.registerSingleton<DeleteNoteUseCase>(
    DeleteNoteUseCase(),
  );
  sl.registerSingleton<EditNoteUseCase>(
    EditNoteUseCase(),
  );

  /***
   * Favoris
  */
  sl.registerSingleton<FavoriesService>(
    FavoriesServiceImpl(),
  );
  sl.registerSingleton<FavoriesRepository>(
    FavoriesRepositoryImpl(),
  );
  sl.registerSingleton<FavorisUseCase>(
    FavorisUseCase(),
  );
  sl.registerSingleton<CreateFavorisUseCase>(
    CreateFavorisUseCase(),
  );
  sl.registerSingleton<DeleteFavorisUseCase>(
    DeleteFavorisUseCase(),
  );


  /***
   * Favoris
  */
  sl.registerSingleton<NotificationService>(
    NotificationServiceImpl(),
  );
  sl.registerSingleton<NotificationRepository>(
    NotificationRepositoryImpl(),
  );
  sl.registerSingleton<SendPinUseCase>(
    SendPinUseCase(),
  );
  sl.registerSingleton<RequestPinUseCase>(
    RequestPinUseCase(),
  );
  sl.registerSingleton<ValidatePinUseCase>(
    ValidatePinUseCase(),
  );

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

  /***
   * User
  */
  sl.registerSingleton<UserService>(
    UserServiceImpl(),
  );
  sl.registerSingleton<UserRepository>(
    UserRepositoryImpl(),
  );
  sl.registerSingleton<UserUseCase>(
    UserUseCase(),
  );

  /***
   * PIN
  */
  // sl.registerSingleton<PinService>(
  //   PinServiceImpl(),
  // );
  // sl.registerSingleton<PinRepository>(
  //   PinRepositoryImpl(),
  // );
  // sl.registerSingleton<SendPinUseCase>(
  //   SendPinUseCase(),
  // );
  // sl.registerSingleton<RequestPinUseCase>(
  //   RequestPinUseCase(),
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
