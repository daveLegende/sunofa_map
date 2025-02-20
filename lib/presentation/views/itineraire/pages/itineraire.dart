import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sunofa_map/common/api/api.dart';
import 'package:sunofa_map/common/widgets/arrow_back.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/presentation/viewsmodels/notes/itineraire.model.dart';
import 'package:sunofa_map/themes/app_themes.dart';

import '../widgets/stack_card.dart';

class ItineraireScreen extends StatefulWidget {
  const ItineraireScreen({
    super.key,
    this.adresse,
  });
  final AdressesEntity? adresse;

  @override
  State<ItineraireScreen> createState() => _ItineraireScreenState();
}

class _ItineraireScreenState extends State<ItineraireScreen> {
  final Completer<GoogleMapController> controller = Completer();
  late GoogleMapController _mapController;
  late LatLng source, destination;
  late Location _location;
  bool isAlertShown = false;
  double distance = 0;
  String estimatedTime = "0";

  List<LatLng> polylineCoordinates = [];
  late StreamSubscription<LocationData> _locationSubscription;
  LatLng? _currentPosition;
  Set<Marker> markers = {};
  Set<Polyline> polyline = {};

  BitmapDescriptor sourceIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLoctionIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);

  @override
  void initState() {
    _location = Location();
    super.initState();
    _initializeLocation();
    final adresse = widget.adresse!;
    destination = LatLng(adresse.latitude, adresse.longitude);
    // _currentPosition =
    //     LatLng(adresse.latitude + 0.002, adresse.longitude - 0.00002);
  }

  Future<void> _initializeLocation() async {
    final hasPermission = await _checkLocationPermission();
    if (hasPermission) {
      final locationData = await _location.getLocation();
      _updateLocation(locationData);

      _locationSubscription =
          _location.onLocationChanged.listen((locationData) {
        _updateLocation(locationData);
      });
    }
  }

  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return false;
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return false;
    }
    return true;
  }

  void _updateLocation(LocationData locationData) {
    if (mounted) {
      setState(() {
        _currentPosition =
            LatLng(locationData.latitude!, locationData.longitude!);
        distance = calculateDistance(_currentPosition!, destination);
        estimatedTime = calculateTime(distance, 10);
        markers = {
          // Marker(
          //   markerId: const MarkerId('current_location'),
          //   position: _currentPosition,
          //   infoWindow: const InfoWindow(title: 'You are here'),
          //   icon: currentLoctionIcon,
          // ),
          Marker(
            markerId: const MarkerId('destination'),
            position: destination,
            infoWindow: InfoWindow(
              title: widget.adresse!.adressName,
            ),
            icon: destinationIcon,
          ),
        };
      });
      // _mapController.animateCamera(CameraUpdate.newLatLngZoom(_currentPosition, 15));

      // Vérifiez la proximité après la mise à jour de la position
      _checkProximity();

      // Recalculate polyline with new position
      getPolyPoints();
    }
  }

  getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: APIURL.apiKey,
      request: PolylineRequest(
        origin: _currentPosition == null
            ? PointLatLng(
                destination.latitude + 0.002,
                destination.longitude - 0.002,
              )
            : PointLatLng(
                _currentPosition!.latitude,
                _currentPosition!.longitude,
              ),
        destination: PointLatLng(destination.latitude, destination.longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();

      // Ajouter le point de départ
      polylineCoordinates.add(_currentPosition!!);

      // Ajouter les points intermédiaires
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      // Ajouter le point d'arrivée
      polylineCoordinates.add(destination);

      setState(() {});
    }
  }

  // Future<void> getPolyPoints() async {
  //   if (_currentPosition == null)
  //     return; // Évite d'exécuter si la position est inconnue

  //   PolylinePoints polylinePoints = PolylinePoints();

  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     googleApiKey: APIURL.apiKey,
  //     request: PolylineRequest(
  //       origin: PointLatLng(
  //         _currentPosition!.latitude,
  //         _currentPosition!.longitude,
  //       ),
  //       destination: PointLatLng(destination.latitude, destination.longitude),
  //       mode: TravelMode.driving,
  //     ),
  //   );

  //   if (result.status == "OK") {
  //     polylineCoordinates.clear();

  //     for (PointLatLng point in result.points) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     }

  //     setState(() {
  //       polyline = {
  //         Polyline(
  //           polylineId: const PolylineId("route"),
  //           points: polylineCoordinates,
  //           color: Colors.blue,
  //           width: 5,
  //         ),
  //       };
  //     });
  //   } else {
  //     print("Erreur Polyline: ${result.errorMessage}");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final adresse = widget.adresse!;
    Size size = MediaQuery.of(context).size;
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: context.width,
            height: context.height,
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              markers: markers,
              initialCameraPosition: CameraPosition(
                target: _currentPosition == null
                    ? LatLng(
                        ((destination.latitude + 0.002) +
                                destination.latitude) /
                            2,
                        (destination.longitude -
                                0.002 +
                                destination.longitude) /
                            2,
                      )
                    : LatLng(
                        (_currentPosition!.latitude + destination.latitude) / 2,
                        (_currentPosition!.longitude + destination.longitude) /
                            2,
                      ),
                zoom: 17.5,
              ),
              polylines: {
                Polyline(
                  polylineId: const PolylineId('route'),
                  points: polylineCoordinates,
                  color: AppTheme.primaryColor,
                  width: 8,
                )
              },
              onMapCreated: (mapController) {
                controller.complete(mapController);
                _mapController = mapController;
              },
            ),
          ),
          const SafeArea(
            child: BackArrow(
              routeNamed: Routes.infoAdresseScreen,
            ),
          ),
          Positioned(
            right: 20,
            top: 50,
            child: GestureDetector(
              onTap: () async {
                GoogleMapController googleMapController =
                    await controller.future;
                googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _currentPosition!,
                      zoom: 17.5,
                    ),
                  ),
                );
              },
              child: ClipOval(
                child: Container(
                  height: 40,
                  width: 40,
                  color: mwhite,
                  child: const Icon(
                    Icons.location_searching,
                    color: mbSecondebleuColorKbe,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: isKeyboardVisible ? null : 20,
            top: isKeyboardVisible ? 90 : null,
            child: CardStack(
              distance: distance,
              estimateTime: estimatedTime,
              destinationName: adresse.adressName,
            ),
          ),
        ],
      ),
    );
  }

  void _checkProximity() {
    if (_currentPosition != null) {
      double distance = _calculateDistance(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        destination.latitude,
        destination.longitude,
      );

      // Si la distance est inférieure à 50 mètres
      if (distance < 50) {
        isAlertShown = true;
        _showProximityAlert();
      }
    }
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371000; // Rayon de la Terre en mètres
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c; // Distance en mètres
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  void _showProximityAlert() {
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Proximité détectée"),
          content: Text("Vous êtes arrivé à destination !"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  void _resetAlertFlag() {
    double distance = _calculateDistance(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      destination.latitude,
      destination.longitude,
    );

    // Si l'utilisateur s'éloigne de plus de 100 mètres, on réinitialise le drapeau
    if (distance > 100) {
      isAlertShown = false;
    }
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }
}
