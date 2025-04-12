// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/blocs/notifications/requestPin/request_pin_cubit.dart';
import 'package:sunofa_map/blocs/notifications/sendPin/send_pin_cubit.dart';
import 'package:sunofa_map/blocs/notifications/validatePin/validate_pin_cubit.dart';
import 'package:sunofa_map/chargement.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/presentation/views/addMap/bloc/create_adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/addresses/bloc/adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/addresses/bloc/delete/delete_adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/auth/bloc/login_cubit.dart';
import 'package:sunofa_map/presentation/views/auth/bloc/register/register_cubit.dart';
import 'package:sunofa_map/presentation/views/books/bloc/book_cubit.dart';
import 'package:sunofa_map/presentation/views/books/bloc/create/create_cubit.dart';
import 'package:sunofa_map/presentation/views/books/bloc/delete/delete_book_cubit.dart';
import 'package:sunofa_map/presentation/views/books/bloc/edit/edit_cubit.dart';
import 'package:sunofa_map/presentation/views/dashboard/bloc/all_adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/editAdresse/bloc/edit_adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_cubit.dart';
import 'package:sunofa_map/presentation/views/notes/bloc/create/create_note_cubit.dart';
import 'package:sunofa_map/presentation/views/notes/bloc/delete/delete_note_cubit.dart';
import 'package:sunofa_map/presentation/views/notes/bloc/edit/edit_note_cubit.dart';
import 'package:sunofa_map/presentation/views/notes/bloc/note_cubit.dart';
import 'package:sunofa_map/presentation/views/profil/bloc/update_user_cubit.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:sunofa_map/services/preferences.dart';
import 'package:sunofa_map/themes/app_themes.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'services/notification_services.dart';

// import 'chargement.dart';

// void main() async {
//   // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   // await EasyLocalization.ensureInitialized();
//   // await initializeDateFormatting('fr_FR', null);
//   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   await EasyLocalization.ensureInitialized();
//   Animate.restartOnHotReload = true;
//   await initializeDateFormatting('fr_FR', '');
//   OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
//   OneSignal.initialize("14bfcd23-b8b1-4ace-9591-ba5aa2b98c36");

//   OneSignal.Notifications.requestPermission(true);

//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//   await initializeDependencies();
//   HttpOverrides.global = MyHttpOverrides();
//   // await FilePermission.getPermissionToImages();
//   // await FilePermission.getPermissionToVideos();
//   // await FilePermission.getPermissionToAudios();
//   runApp(
//     EasyLocalization(
//       supportedLocales: const [Locale('en'), Locale('fr')],
//       path: 'assets/translations',
//       fallbackLocale: const Locale('en'),
//       child: const MyApp(),
//     ),
//   );

//   FlutterNativeSplash.remove();
// }
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// void main() async {
//   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   // await PreferenceServices().removeToken().then((_) async {
//   //   await PreferenceServices().removeUser().then((_) {});
//   // });
//   // Initialize OneSignal
//   OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
//   OneSignal.initialize("14bfcd23-b8b1-4ace-9591-ba5aa2b98c36");

//   await PreferenceServices().clearAllNotifications();

//   // Request notification permission
//   await OneSignal.Notifications.requestPermission(true);

//   // Save permission in SharedPreferences
//   await PreferenceServices().saveNotificationPermission();

//   // Handle foreground notifications
//   OneSignal.Notifications.addForegroundWillDisplayListener((event) async {
//     event.notification.display();
//     OneSignal.Notifications.displayNotification(
//       event.notification.notificationId,
//     );
//     print("-----------------------");
//     print("-----------------------");
//     print("-----------${event.notification} ------------");
//     print("------------dffhd-----------");
//     print("-----------------------");

//     await PreferenceServices().saveNotification(event.notification);
//   });

//   // Handle notification clicks
//   OneSignal.Notifications.addClickListener((event) async {
//     print('NOTIFICATION CLICKED: ${event.notification.body}');

//     // await PreferenceServices().saveNotification(event.notification);
//     // Prevent duplicate navigations
//     if (navigatorKey.currentState != null) {
//       navigatorKey.currentState?.pushNamed(Routes.notifScreen);
//     }
//   });

//   // Initialize localization and other dependencies
//   await EasyLocalization.ensureInitialized();
//   Animate.restartOnHotReload = true;
//   await initializeDateFormatting('fr_FR', '');

//   // Set preferred orientations
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);

//   // Preserve splash screen
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

//   // Initialize dependencies
//   await initializeDependencies();
//   HttpOverrides.global = MyHttpOverrides();

//   // Run the app
//   runApp(
//     EasyLocalization(
//       supportedLocales: const [Locale('en'), Locale('fr')],
//       path: 'assets/translations',
//       fallbackLocale: const Locale('en'),
//       saveLocale: true,
//       child: const MyApp(),
//     ),
//   );

//   // Remove splash screen
//   FlutterNativeSplash.remove();
// }

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  
  // Initialisation OneSignal
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("14bfcd23-b8b1-4ace-9591-ba5aa2b98c36");

  await PreferenceServices().clearAllNotifications();
  await OneSignal.Notifications.requestPermission(true);
  await PreferenceServices().saveNotificationPermission();

  // Gestion des notifications reçues (foreground et background)
  OneSignal.Notifications.addForegroundWillDisplayListener((event) async {
    // Afficher la notification
    event.notification.display();
    
    // Enregistrer la notification dès réception
    print("Notification reçue: ${event.notification}");
    await PreferenceServices().saveNotification(event.notification);
  });

  // Gestion des clics sur notification (sans enregistrement)
  OneSignal.Notifications.addClickListener((event) async {
    print('Notification cliquée: ${event.notification.body}');
    
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState?.pushNamed(Routes.notifScreen);
    }
    await PreferenceServices().saveNotification(event.notification);
  });

  // Initialisation des autres dépendances
  await EasyLocalization.ensureInitialized();
  Animate.restartOnHotReload = true;
  await initializeDateFormatting('fr_FR', '');
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initializeDependencies();
  HttpOverrides.global = MyHttpOverrides();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('fr')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      child: const MyApp(),
    ),
  );

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const _designSize = Size(375, 812);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit()..getCurrentUser(),
        ),
        BlocProvider<UpdateUserCubit>(
          create: (context) => UpdateUserCubit(),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider<AdresseCubit>(
          create: (context) => AdresseCubit()..getAdresses(),
        ),
        BlocProvider<AllAdresseCubit>(
          create: (context) => AllAdresseCubit()..getAllAdresses(),
        ),
        BlocProvider<CreateAdresseCubit>(
          create: (context) => CreateAdresseCubit(),
        ),
        BlocProvider<EditAdresseCubit>(
          create: (context) => EditAdresseCubit(),
        ),
        BlocProvider<DeleteAdresseCubit>(
          create: (context) => DeleteAdresseCubit(),
        ),
        BlocProvider<BookCubit>(
          create: (context) => BookCubit()..getBooks(),
        ),
        BlocProvider<CreateBookCubit>(
          create: (context) => CreateBookCubit(),
        ),
        BlocProvider<DeleteBookCubit>(
          create: (context) => DeleteBookCubit(),
        ),
        BlocProvider<EditBookCubit>(
          create: (context) => EditBookCubit(),
        ),
        BlocProvider<NoteCubit>(
          create: (context) => NoteCubit()..getNotes(),
        ),
        BlocProvider<SendPinCubit>(
          create: (context) => SendPinCubit(),
        ),
        BlocProvider<RequestPinCubit>(
          create: (context) => RequestPinCubit(),
        ),
        BlocProvider<ValidatePinCubit>(
          create: (context) => ValidatePinCubit(),
        ),
        BlocProvider<CreateNoteCubit>(
          create: (context) => CreateNoteCubit(),
        ),
        BlocProvider<EditNoteCubit>(
          create: (context) => EditNoteCubit(),
        ),
        BlocProvider<DeleteNoteCubit>(
          create: (context) => DeleteNoteCubit(),
        ),
        BlocProvider(
          create: (context) => LangueChooseBloc(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: _designSize,
          minTextAdapt: true,
          builder: (_, child) {
            return BlocListener<LangueChooseBloc, LangueChooseState>(
              listener: (context, state) {
                // if (state is LangueChooseState) {
                context.setLocale(state.selectedLocale);
                // }
                // navigatorKey.currentState?.pushReplacementNamed('/');
              },
              child: BlocBuilder<LangueChooseBloc, LangueChooseState>(
                builder: (context, state) {
                  return MaterialApp(
                    navigatorKey: navigatorKey,
                    // navigatorKey: navigatorKey,
                    title: 'Sunofa Map',
                    theme: AppTheme.lightTheme,
                    // localizationsDelegates: context.localizationDelegates,
                    // supportedLocales: context.supportedLocales,
                    // locale: context.locale,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    localizationsDelegates: context.localizationDelegates,
                    initialRoute: Routes.chargement,
                    onGenerateRoute: Routes.generateRoute,
                    debugShowCheckedModeBanner: false,
                    // home: const Chargement(),
                  );
                },
              ),
            );
          }),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Stream<Locale> setLocale(int choice) {
  var localeSubject = BehaviorSubject<Locale>();

  choice == 0
      ? localeSubject.sink.add(Locale('fr', ''))
      : localeSubject.sink.add(Locale('en', ''));

  return localeSubject.stream.distinct();
}
