import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/presentation/views/addresses/bloc/adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/auth/bloc/login_cubit.dart';
import 'package:sunofa_map/presentation/views/auth/bloc/register/register_cubit.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:sunofa_map/themes/app_themes.dart';
import 'package:get/get.dart';

void main() async {
  await initializeDateFormatting('fr_FR', null);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await initializeDependencies();
  runApp(const MyApp());
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
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider<AdresseCubit>(
          create: (context) => AdresseCubit()..getAdresses(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Sunofa Map',
        theme: AppTheme.lightTheme,
        initialRoute: Routes.chargement,
        onGenerateRoute: Routes.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
