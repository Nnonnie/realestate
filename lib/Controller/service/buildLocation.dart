import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_location/fl_location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../Controller/service/estateLocation.dart';
import '../../Model/location.dart';

LatLng? currentLocation; // To store current location
List<EstateLocations> nearbyLocations = [];

class buildLocation {
  static Future<void> getCurrentLocation() async {
    try {
      Location location = await FlLocation.getLocation();
      if (location.latitude == null || location.longitude == null) {
        // Location is not available, prompt the user to enable location
        //showLocationDialog(con);
      } else {
        // Location fetched successfully

        currentLocation = LatLng(location.latitude!, location.longitude!);

        // Fetch nearby locations after getting the current location
        fetchNearbyLocations();
      }
    } catch (e) {
      // Error occurred, handle it (e.g., show error message)
      print("Error fetching location: $e");
    }
  }

  // Fetch nearby locations (simulating an API call)
  static Future<void> fetchNearbyLocations() async {
    if (currentLocation != null) {
      List<EstateLocations> nearbyLocations =
          await fetchNearbyEstateLocationss(currentLocation!);

      nearbyLocations = nearbyLocations;
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
