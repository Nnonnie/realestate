// map_screen.dart
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fl_location/fl_location.dart';
import 'package:http/http.dart' as http;
import 'package:realestate/Constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realestate/Controller/utility.dart';
import '../../Constants/values.dart';
import '../../Controller/service/estateLocation.dart';

import '../../Model/location.dart';
import 'components/bottomFloatingContainer.dart';
import 'components/searchAppBar.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _currentLocation;
  List<EstateLocations> _nearbyLocations = [];
  bool isExpanded = false;
  late final Future<void> delayedFuture;

  @override
  void initState() {
    super.initState();
    _checkPermissionAndGetLocation();

    delayedFuture = Future.delayed(Duration(seconds: 6), () {
      if (mounted) {
        setState(() {
          isExpanded = true;
        });
      }
    });
  }

  Future<void> _checkPermissionAndGetLocation() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      await _getCurrentLocation();
    } else {
      print("Permission denied");
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Location location = await FlLocation.getLocation();
      if (location.latitude == 0.0 || location.longitude == 0.0) {
        _showLocationDialog();
      } else {
        setState(() {
          _currentLocation = LatLng(location.latitude, location.longitude);
        });

        _fetchNearbyLocations();
      }
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  Future<void> _fetchNearbyLocations() async {
    if (_currentLocation != null) {
      List<EstateLocations> nearbyLocations =
          await fetchNearbyEstateLocationss(_currentLocation!);
      setState(() {
        _nearbyLocations = nearbyLocations;
      });
    }
  }

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
                  urlTemplate: "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png",
                  // CartoDB Positron
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    ..._nearbyLocations.map((location) => Marker(
                          width: isExpanded == true ? 30 : 80,
                          height: isExpanded == true ? 40 : 40,
                          point: LatLng(location.latitude, location.longitude),
                          child: AnimatedContainer(
                            curve: Curves.easeInOut,
                            duration: Duration(seconds: 5),
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
                              replacement:
                                  Center(child: Text(location.name.toString())),
                            ),
                          ),
                        )),
                  ],
                ),
                SearchAppBar(),
                BottomFLoatingContainer()
              ],
            ),
    );
  }
}
