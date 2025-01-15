import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sunofa_map/common/api/api.dart';
import 'package:sunofa_map/common/widgets/arrow_back.dart';
import 'package:sunofa_map/common/widgets/fields/simple_textfield.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/themes/app_themes.dart';

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
  late LatLng source, destination;
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  Set<Marker> markers = {};
  Set<Polyline> polyline = {};

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLoctionIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
    final adresse = widget.adresse!;
    source = LatLng(
      adresse.latitude - 0.008,
      adresse.longitude + 0.08,
    );
    destination = LatLng(
      adresse.latitude,
      adresse.longitude,
    );

    // setCustomMarkerIcon();
    getPolyPoints();
  }

  getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: APIURL.apiKey,
      request: PolylineRequest(
        origin: PointLatLng(source.latitude, source.longitude),
        destination: PointLatLng(destination.latitude, destination.longitude),
        mode: TravelMode.driving,
        // wayPoints: [PolylineWayPoint(location: widget.adresse!.adressName)],
      ),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) =>
            polylineCoordinates.add(LatLng(point.latitude, point.longitude)),
      );
      setState(() {});
    }
  }

  // getCurrentLocation() async {
  //   Location location = Location();
  //   location.getLocation().then((location) {
  //     setState(() {
  //       currentLocation = location;
  //     });
  //   });

  //   GoogleMapController googleMapController = await controller.future;

  //   location.onLocationChanged.listen((newLoc) {
  //     currentLocation = newLoc;
  //     googleMapController.animateCamera(CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //         zoom: 13.5,
  //         target: LatLng(newLoc.latitude!, newLoc.longitude!),
  //       ),
  //     ));
  //     setState(() {});
  //   });
  // }

  getCurrentLocation() async {
    Location location = Location();

    // Récupérer la position initiale
    location.getLocation().then((locationData) {
      setState(() {
        currentLocation = locationData;
      });
    });

    GoogleMapController googleMapController = await controller.future;

    // Écouter les changements de position en temps réel
    location.onLocationChanged.listen((newLocation) async {
      setState(() {
        currentLocation = newLocation;
      });

      // Animer la caméra vers la nouvelle position
      // googleMapController.animateCamera(
      //   CameraUpdate.newCameraPosition(
      //     CameraPosition(
      //       target: LatLng(newLocation.latitude!, newLocation.longitude!),
      //       zoom: 13.5,
      //     ),
      //   ),
      // );

      // Ajouter la nouvelle position aux polylineCoordinates pour dessiner la route
      // polylineCoordinates.add(
      //   LatLng(newLocation.latitude!, newLocation.longitude!),
      // );

      // Mettre à jour les polylines sur la carte
      setState(() {});
    });
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.asset(ImageConfiguration.empty, "assets/pin_source.png")
        .then((icon) {
      setState(() {
        sourceIcon = icon;
      });
    });
    BitmapDescriptor.asset(
            ImageConfiguration.empty, "assets/pin_destination.png")
        .then((icon) {
      setState(() {
        destinationIcon = icon;
      });
    });
    BitmapDescriptor.asset(ImageConfiguration.empty, "assets/pin_location.png")
        .then((icon) {
      setState(() {
        currentLoctionIcon = icon;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final adresse = widget.adresse!;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: context.width,
            height: context.height,
            child: GoogleMap(
              markers: {
                Marker(
                  markerId: const MarkerId("Ma Position"),
                  position: currentLocation == null
                      ? LatLng(
                          (source.latitude + destination.latitude) / 2,
                          (source.longitude + destination.longitude) / 2,
                        )
                      : LatLng(
                          currentLocation!.latitude!,
                          currentLocation!.longitude!,
                        ),
                  infoWindow: const InfoWindow(
                    title: "My Position",
                  ),
                  icon: currentLocation == null
                      ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta) : currentLoctionIcon,
                ),
                Marker(
                  markerId: const MarkerId("source"),
                  position: source,
                  infoWindow: const InfoWindow(
                    title: "Source",
                  ),
                  icon: sourceIcon,
                ),
                Marker(
                  markerId: const MarkerId("destination"),
                  position: destination,
                  infoWindow: InfoWindow(
                    title: adresse.adressName,
                  ),
                  icon: destinationIcon,
                ),
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  (source.latitude + destination.latitude) / 2,
                  (source.longitude + destination.longitude) / 2,
                ),
                zoom: 12.5,
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
                      target: LatLng(
                        currentLocation!.latitude!,
                        currentLocation!.longitude!,
                      ),
                      zoom: 13.5,
                    ),
                  ),
                );
              },
              child: ClipOval(
                child: Container(
                  height: 40,
                  width: 40,
                  color: mwhite,
                  child: Icon(
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
            bottom: 20,
            child: Card(
              elevation: 10,
              child: Container(
                height: context.width / 2.5,
                decoration: BoxDecoration(
                  color: mwhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: SimpleTextField(
                      hintText: "hintText",
                      controller: TextEditingController()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class LiveLocationTracking extends StatefulWidget {
  @override
  _LiveLocationTrackingState createState() => _LiveLocationTrackingState();
}

class _LiveLocationTrackingState extends State<LiveLocationTracking> {
  late GoogleMapController _mapController;
  late Location _location;
  late StreamSubscription<LocationData> _locationSubscription;
  Set<Marker> _markers = {};
  LatLng _currentPosition = LatLng(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    _location = Location();

    // Check permissions and listen to location changes
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    final hasPermission = await _checkLocationPermission();
    if (hasPermission) {
      final locationData = await _location.getLocation();
      _updateLocation(locationData);

      _locationSubscription = _location.onLocationChanged.listen((locationData) {
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

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _updateLocation(LocationData locationData) {
    if (mounted) {
      setState(() {
        _currentPosition = LatLng(locationData.latitude!, locationData.longitude!);
        _markers = {
          Marker(
            markerId: MarkerId('current_location'),
            position: _currentPosition,
            infoWindow: InfoWindow(title: 'You are here'),
          ),
        };
      });
      _mapController.animateCamera(CameraUpdate.newLatLngZoom(_currentPosition, 15));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Location Tracking")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _currentPosition, zoom: 15),
        onMapCreated: _onMapCreated,
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.location_on),
      ),
    );
  }

  @override
  void dispose() {
    _locationSubscription.cancel(); // Cancel the subscription to avoid memory leaks
    super.dispose();
  }
}