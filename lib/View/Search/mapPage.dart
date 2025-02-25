// map_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fl_location/fl_location.dart';
import 'package:http/http.dart' as http;
import 'package:realestate/Constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Constants/values.dart';
import '../../Controller/service/estateLocation.dart';
import '../../Model/address.dart';
import '../../Model/location.dart';
import 'components/bottomFloatingContainer.dart';
import 'components/searchAppBar.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _currentLocation; // To store current location
  List<EstateLocations> _nearbyLocations = []; // List of nearby locations
  bool isExpanded = false;
  Address address = Address();

  @override
  void initState() {
    super.initState();
    _checkPermissionAndGetLocation();

    // Check permission and get current location
    Future.delayed(Duration(seconds: 7), () {
      setState(() {
        isExpanded = true;
      });
    });
  }

  // Request permission and get current location
  Future<void> _checkPermissionAndGetLocation() async {
    // Request location permission
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      // Permission granted, get current location
      await _getCurrentLocation();
    } else {
      // Handle permission denial
      print("Permission denied");
    }
  }

  // Get current location using fl_location
  Future<void> _getCurrentLocation() async {
    try {
      Location location = await FlLocation.getLocation();
      if (location.latitude == null || location.longitude == null) {
        // Location is not available, prompt the user to enable location
        _showLocationDialog();
      } else {
        // Location fetched successfully
        setState(() {
          _currentLocation = LatLng(location.latitude!, location.longitude!);
          _getAddressFromLatLng(
              _currentLocation!.latitude, _currentLocation!.longitude);
        });
        // Fetch nearby locations after getting the current location
        _fetchNearbyLocations();
      }
    } catch (e) {
      // Error occurred, handle it (e.g., show error message)
      print("Error fetching location: $e");
    }
  }

  // Fetch nearby locations (simulating an API call)
  Future<void> _fetchNearbyLocations() async {
    if (_currentLocation != null) {
      List<EstateLocations> nearbyLocations =
          await fetchNearbyEstateLocationss(_currentLocation!);
      setState(() {
        _nearbyLocations = nearbyLocations;
      });
    }
  }

  // Show dialog to prompt the user to turn on location
  void _showLocationDialog() {
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

  Future<Address?> _getAddressFromLatLng(
      double latitude, double longitude) async {
    try {
      final url = Uri.parse(
          'https://nominatim.openstreetmap.org/reverse?lat=$latitude&lon=$longitude&format=json&addressdetails=1');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Create an Address object using the data
        address = Address.fromJson(data);

        print("Street: ${address.street}");
        print("City: ${address.city}");
        print("Country: ${address.country}");

        return address; // You can use this Address object wherever needed
      } else {
        print("Failed to fetch address");
        return null;
      }
    } catch (e) {
      print("Error fetching address: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.black,
      body: _currentLocation == null
          ? Center(
              child: CircularProgressIndicator(
              color: Palette.Orange,
            ))
          : FlutterMap(
              options: MapOptions(
                backgroundColor: Palette.black,
                initialCenter: _currentLocation!,
                minZoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png',
                  // CartoDB Positron
                  subdomains: ['a', 'b', 'c'],
                ),
                SearchAppBar(location: address),
                MarkerLayer(
                  markers: [
                    /*      Marker(
                point: _currentLocation!,
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  width: isExpanded ? 20 : 40,
                  // Expanding from small to big
                  height: isExpanded ? 20 : 40,
                  decoration: BoxDecoration(
                    color: Palette.Orange,
                    shape: BoxShape.circle,
                  ),
                  child: Visibility(
                    visible:isExpanded,
                    child: Icon(Icons.location_pin, color: Colors.white),


                  ),
                ),
              ),*/
                    ..._nearbyLocations.map((location) => Marker(
                          point: LatLng(location.latitude, location.longitude),
                          child: AnimatedContainer(
                            curve: Curves.easeIn,
                            duration: Duration(seconds: 5),
                            width: isExpanded ? 100 : 20,
                            // Expanding from small to big
                            height: isExpanded ? 200 : 20,
                            decoration: BoxDecoration(
                              color: Palette.Orange,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                // Curved top-left corner
                                bottomRight: Radius.circular(5),
                              ),
                            ),

                            child: Visibility(
                              visible: isExpanded,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SvgPicture.asset(
                                  height: 5,
                                  width: 5,
                                  ImagePath.solarBuildingline,
                                  color: Palette.white,
                                ),
                              ),
                              replacement: Text(location.name.toString()),
                            ),
                          ),
                        )),
                  ],
                ),
                BottomFLoatingContainer()
              ],
            ),
    );
  }
}
