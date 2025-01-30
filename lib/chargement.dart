import 'package:flutter/material.dart';
import 'package:sunofa_map/presentation/views/home/pages/home.dart';
import 'package:sunofa_map/presentation/views/onboarding/onboarding_screen.dart';
import 'services/preferences.dart';

class Chargement extends StatefulWidget {
  const Chargement({super.key});

  @override
  State<Chargement> createState() => _ChargementState();
}

class _ChargementState extends State<Chargement> {
  String? token = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  // Méthode asynchrone pour charger le token
  Future<void> _loadToken() async {
    token = await PreferenceServices().getToken();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (token == null || token!.isEmpty) {
      return const OnboardingScreen();
    } else {
      return const Home();
    }
  }
}
