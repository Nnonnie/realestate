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
      latitude: currentEstateLocations.latitude + 0.01,
      longitude: currentEstateLocations.longitude,
      name: "EstateLocations 1 (North)",
    ),
    EstateLocations(
      latitude: currentEstateLocations.latitude - 0.01,
      longitude: currentEstateLocations.longitude,
      name: "EstateLocations 2 (South)",
    ),
    EstateLocations(
      latitude: currentEstateLocations.latitude,
      longitude: currentEstateLocations.longitude + 0.01,
      name: "EstateLocations 3 (East)",
    ),
    EstateLocations(
      latitude: currentEstateLocations.latitude,
      longitude: currentEstateLocations.longitude - 0.01,
      name: "EstateLocations 4 (West)",
    ),
    EstateLocations(
      latitude: currentEstateLocations.latitude + 0.005,
      longitude: currentEstateLocations.longitude + 0.005,
      name: "EstateLocations 5 (Northeast)",
    ),
    EstateLocations(
      latitude: currentEstateLocations.latitude - 0.005,
      longitude: currentEstateLocations.longitude - 0.005,
      name: "EstateLocations 6 (Southwest)",
    ),
  ];

  return nearbyEstateLocationss;
}
