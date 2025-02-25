// EstateLocations_service.dart
import 'dart:async';
import 'package:latlong2/latlong.dart';

import '../../Model/location.dart';

// Simulating an API call to fetch nearby EstateLocationss
Future<List<EstateLocations>> fetchNearbyEstateLocationss(LatLng currentEstateLocations) async {
  // Simulate a delay as if calling an API
  await Future.delayed(Duration(seconds: 2));

  // List of nearby EstateLocationss (simulated data, could be fetched from an API)
  List<EstateLocations> nearbyEstateLocationss = [
    EstateLocations(
      latitude: currentEstateLocations.latitude + 0.02,
      longitude: currentEstateLocations.longitude,
      name: "10,3 mmP",
    ),
    EstateLocations(
      latitude: currentEstateLocations.latitude - 0.02,
      longitude: currentEstateLocations.longitude,
      name: "13,3 mmP",
    ),
    EstateLocations(
      latitude: currentEstateLocations.latitude,
      longitude: currentEstateLocations.longitude + 0.02,
      name: "11,3 mmP",
    ),
    EstateLocations(
      latitude: currentEstateLocations.latitude,
      longitude: currentEstateLocations.longitude - 0.02,
      name: "6,95 mmP",
    ),
    EstateLocations(
      latitude: currentEstateLocations.latitude + 0.004,
      longitude: currentEstateLocations.longitude + 0.005,
      name: "8,5 mmP",
    ),
    EstateLocations(
      latitude: currentEstateLocations.latitude - 0.005,
      longitude: currentEstateLocations.longitude - 0.005,
      name: "7,8 mmP",
    ),
  ];

  return nearbyEstateLocationss;
}
