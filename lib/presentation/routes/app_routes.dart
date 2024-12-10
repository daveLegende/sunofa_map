import 'package:flutter/material.dart';
import 'package:sunofa_map/chargement.dart';
import 'package:sunofa_map/presentation/views/about/about.dart';
import 'package:sunofa_map/presentation/views/addMap/pages/add_map_form_screen.dart';
import 'package:sunofa_map/presentation/views/addresses/pages/addresses.dart';
import 'package:sunofa_map/presentation/views/books/pages/books.dart';
import 'package:sunofa_map/presentation/views/dashboard/pages/dashboard_screen.dart';
import 'package:sunofa_map/presentation/views/editAdresse/pages/edit_adresse.dart';
import 'package:sunofa_map/presentation/views/favoris/pages/favorites.dart';
import 'package:sunofa_map/presentation/views/gestionAdresse/pages/gestion_adresse.dart';
import 'package:sunofa_map/presentation/views/home/pages/home.dart';
import 'package:sunofa_map/presentation/views/auth/pages/login_screen.dart';
import 'package:sunofa_map/presentation/views/auth/pages/register_screen.dart';
import 'package:sunofa_map/presentation/views/infos/pages/infos.dart';
import 'package:sunofa_map/presentation/views/itineraire/pages/itineraire.dart';
import 'package:sunofa_map/presentation/views/notes/pages/add_notes.dart';
import 'package:sunofa_map/presentation/views/notes/pages/notes.dart';
import 'package:sunofa_map/presentation/views/notification/pages/notification.dart';
import 'package:sunofa_map/presentation/views/onboarding/onboarding_screen.dart';
import 'package:sunofa_map/presentation/views/params/pages/params.dart';
import 'package:sunofa_map/presentation/views/pin/pages/pin.dart';
import 'package:sunofa_map/presentation/views/profil/pages/profil.dart';

class Routes {
  static const String home = '/';
  static const String home2 = '/Home';
  static const String chargement = '/ChargementScreen';
  static const String loginScreen = '/Loginscreen';
  static const String registerScreen = '/Registerscreen';
  static const String dashboardScreen = '/Dashboardscreen';
  static const String addMapFormScreen = '/AddMapFormScreen';
  static const String infoAdresseScreen = '/InfoAdresseScreen';
  static const String itineraireScreen = '/ItineraireScreen';
  static const String gestionAdresseScreen = '/GestionAdresseScreen';
  static const String editAdresseScreen = '/EditAdresseScreen';
  static const String paramScreen = '/ParamScreen';
  //Routes pour lze menus de navigation
  static const String aboutScreen = '/AboutScreen';
  static const String notifScreen = '/NotifScreen';
  static const String notesScreen = '/NotesScreen';
  static const String addNotesScreen = '/AddNotesScreen';
  static const String addressBookScreen = '/AddressBookScreen';
  static const String favScreen = '/FavScreen';
  static const String myaddressesScreen = '/MyAddressesScreen';
  static const String profilScreen = '/ProfilScreen';
  static const String pinScreen = '/PinScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());
      case home2:
        return MaterialPageRoute(builder: (context) => const Home());
      case chargement:
        return MaterialPageRoute(builder: (context) => const Chargement());
      case registerScreen:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case dashboardScreen:
        return MaterialPageRoute(builder: (context) => const DashboardScreen());
      case addMapFormScreen:
        return MaterialPageRoute(
            builder: (context) => const AddMapFormScreen());
      case aboutScreen:
        return MaterialPageRoute(builder: (context) => const AboutScreen());
      case notifScreen:
        return MaterialPageRoute(
            builder: (context) => const NotificationScreen());
      case infoAdresseScreen:
        return MaterialPageRoute(
            builder: (context) => const InfoAdresseScreen());
      case itineraireScreen:
        return MaterialPageRoute(
            builder: (context) => const ItineraireScreen());
      case gestionAdresseScreen:
        return MaterialPageRoute(
            builder: (context) => const GestionAdresseScreen());
      case notesScreen:
        return MaterialPageRoute(builder: (context) => const NoteScreen());
      case editAdresseScreen:
        return MaterialPageRoute(builder: (context) => const EditAdresseScreen());
      case addressBookScreen:
        return MaterialPageRoute(builder: (context) => const BooksScreen());
      case favScreen:
        return MaterialPageRoute(builder: (context) => const FavoriteScreen());
      case myaddressesScreen:
        return MaterialPageRoute(builder: (context) => const AddresseScreen());
      case profilScreen:
        return MaterialPageRoute(
            builder: (context) => const ProfilScreen());
      case paramScreen:
        return MaterialPageRoute(
            builder: (context) => const ParamScreen());
      case addNotesScreen:
        return MaterialPageRoute(
            builder: (context) => const AddNoteScreen());
      case pinScreen:
        return MaterialPageRoute(
            builder: (context) => const PinScreen());
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
