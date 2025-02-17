// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
import 'package:sunofa_map/themes/app_themes.dart';
import 'package:get/get.dart';

// import 'chargement.dart';

void main() async {
  await initializeDateFormatting('fr_FR', null);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initializeDependencies();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        BlocProvider<CreateNoteCubit>(
          create: (context) => CreateNoteCubit(),
        ),
        BlocProvider<EditNoteCubit>(
          create: (context) => EditNoteCubit(),
        ),
        BlocProvider<DeleteNoteCubit>(
          create: (context) => DeleteNoteCubit(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Sunofa Map',
        theme: AppTheme.lightTheme,
        initialRoute: Routes.chargement,
        onGenerateRoute: Routes.generateRoute,
        debugShowCheckedModeBanner: false,
        // home: AudioRecorderScreen(),
      ),
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
