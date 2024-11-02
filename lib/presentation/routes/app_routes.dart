import 'package:flutter/material.dart';
import 'package:sunofa_map/presentation/views/app_screens/add_map_form_screen.dart';
import 'package:sunofa_map/presentation/views/app_screens/dashboard_screen.dart';
import 'package:sunofa_map/presentation/views/app_screens/navigation_drawer_screens/about_screen.dart';
import 'package:sunofa_map/presentation/views/app_screens/navigation_drawer_screens/address_book_screen.dart';
import 'package:sunofa_map/presentation/views/app_screens/navigation_drawer_screens/favorites_screen.dart';
import 'package:sunofa_map/presentation/views/app_screens/navigation_drawer_screens/notes_screen.dart';
import 'package:sunofa_map/presentation/views/app_screens/navigation_drawer_screens/notifications_screen.dart';
import 'package:sunofa_map/presentation/views/auth/login_screen.dart';
import 'package:sunofa_map/presentation/views/auth/register_screen.dart';
import 'package:sunofa_map/presentation/views/onboarding/onboarding_screen.dart';

import '../views/app_screens/navigation_drawer_screens/my_addresses_screen.dart';

class Routes {
  static const String home = '/';
  static const String loginScreen = '/Loginscreen';
  static const String registerScreen = '/Registerscreen';
  static const String dashboardScreen = '/Dashboardscreen';
  static const String addMapFormScreen = '/AddMapFormScreen';
  //Routes pour lze menus de navigation
  static const String aboutScreen = '/AboutScreen';
  static const String notifScreen = '/NotifScreen';
  static const String notesScreen = '/NotesScreen';
  static const String addressBookScreen = '/AddressBookScreen';
   static const String favScreen = '/FavScreen';
   static const String myaddressesScreen = '/MyAddressesScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case dashboardScreen:
        return MaterialPageRoute(builder: (context) => const DashboardScreen());
      case addMapFormScreen:
        return MaterialPageRoute(
            builder: (context) => const AddMapFormScreen());
      case aboutScreen:
        return MaterialPageRoute(builder: (context) => const AboutScreen());
      case notifScreen:
        return MaterialPageRoute(
            builder: (context) => const NotificationsScreen());
      case notesScreen:
        return MaterialPageRoute(builder: (context) => const NotesScreen());
         case addressBookScreen:
        return MaterialPageRoute(builder: (context) => const AddressBookScreen());
        case favScreen:
        return MaterialPageRoute(builder: (context) => const FavoritesScreen());
         case myaddressesScreen:
        return MaterialPageRoute(builder: (context) => const MyAddressesScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Pas de routes défini ${settings.name}'),
            ),
          ),
        );
    }
  }
}
