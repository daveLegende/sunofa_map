import 'package:flutter/material.dart';
import 'package:sunofa_map/presentation/views/home/pages/home.dart';
import 'package:sunofa_map/presentation/views/onboarding/onboarding_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'domain/entities/adresses/adresse.entity.dart';
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

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({
    super.key,
    this.adresse,
  });
  final AdressesEntity? adresse;

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController mapController;

  // Définir une méthode pour capturer le contrôleur de la carte
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final adresse = widget.adresse!;
    // Définissez la position initiale de la carte
    final LatLng initialPosition = LatLng(adresse.latitude, adresse.longitude);
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: initialPosition,
          zoom: 15,
        ),
        mapType: MapType.normal, // Autres options : satellite, terrain, hybrid
        myLocationEnabled: true, // Afficher la position actuelle
        compassEnabled: true, // Activer la boussole
        markers: {
          Marker(
            markerId: const MarkerId("marker_1"),
            position: LatLng(adresse.latitude, adresse.latitude),
            infoWindow: InfoWindow(
              title: adresse.adressName,
              snippet: adresse.city,
            ),
          ),
        },
        zoomControlsEnabled: true, // Contrôle de zoom
      ),
    );
  }
}
