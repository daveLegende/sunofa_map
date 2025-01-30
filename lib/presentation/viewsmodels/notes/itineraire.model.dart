import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

double calculateDistance(LatLng start, LatLng destination) {
  const double earthRadius = 6371; // Rayon de la Terre en kilomètres

  double dLat = _toRadians(destination.latitude - start.latitude);
  double dLon = _toRadians(destination.longitude - start.longitude);

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_toRadians(start.latitude)) *
          cos(_toRadians(destination.latitude)) *
          sin(dLon / 2) *
          sin(dLon / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadius * c;
}

double _toRadians(double degree) {
  return degree * pi / 180;
}

String calculateTime(double distance, double speed) {
  if (speed <= 0) return "Vitesse invalide";

  double timeInHours = distance / speed;
  int hours = timeInHours.floor();
  int minutes = ((timeInHours - hours) * 60).floor();
  int seconds = (((timeInHours - hours) * 60 - minutes) * 60).floor();

  return "${hours}h ${minutes}m ${seconds}s";
}

// void main() {
//   // Coordonnées de départ et de destination
//   Location start = Location(6.5244, 3.3792); // Lagos, Nigéria
//   Location destination = Location(6.4654, 3.4064); // Ikeja, Nigéria

//   double distance = calculateDistance(start, destination);
//   print("Distance: ${distance.toStringAsFixed(2)} km");

//   double speed = 60; // Vitesse en km/h
//   String estimatedTime = calculateTime(distance, speed);
//   print("Temps estimé: $estimatedTime");
// }
