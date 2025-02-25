import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_location/fl_location.dart';
import 'package:latlong2/latlong.dart';
import '../../Controller/service/estateLocation.dart';
import '../../Model/location.dart';
import 'package:http/http.dart' as http;

LatLng? currentLocation;
List<EstateLocations> nnearbyLocations = [];

class buildLocation {
  // To store current location

  static Future<LatLng?> getCurrentLocation() async {
    try {
      Location location = await FlLocation.getLocation();
      if (location.latitude == 0.0 || location.longitude == 0.0) {
      } else {
        currentLocation = LatLng(location.latitude!, location.longitude!);

        // Fetch nearby locations after getting the current location
        fetchNearbyLocations();
        return currentLocation;
      }
    } catch (e) {
      // Error occurred, handle it (e.g., show error message)
      print("Error fetching location: $e");
    }
    return currentLocation;
  }

  // Fetch nearby locations (simulating an API call)
  static Future<void> fetchNearbyLocations() async {
    if (currentLocation != null) {
      List<EstateLocations> nearbyLocations =
          await fetchNearbyEstateLocationss(currentLocation!);

      nnearbyLocations = nearbyLocations;
    }
  }

  // Show dialog to prompt the user to turn on location
  static void showLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Location Services Disabled"),
          content: Text(
              "Please enable location services on your device to access the map."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }


}
