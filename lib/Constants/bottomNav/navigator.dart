import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:realestate/View/Home/homePage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fl_location/fl_location.dart';

import 'package:realestate/Constants/colors.dart';
import 'package:realestate/Controller/service/buildLocation.dart';

import '../../View/EstateMap/mapPage.dart';

import '../values.dart';
import 'component/navv.dart';

//import 'package:flutter_svg/flutter_svg.dart';

class BottomNav extends StatefulWidget {
  BottomNav({
    Key? key,
  }) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  int state = 0;
  DateTime backPressedTime = DateTime.now();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    currentPage = 2; // Ensure Home tab is selected initially
    tabController = TabController(
        length: 5,
        vsync: this,
        initialIndex: currentPage); // Set initial index to 2
    tabController.animation!.addListener(_tabControllerListener);
    checkPermissionAndGetLocation();
  }

  // Request permission and get current location
  Future<void> checkPermissionAndGetLocation() async {
    // Request location permission
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      // Permission granted, get current location
      await buildLocation.getCurrentLocation();
    } else {
      // Handle permission denial
      print("Permission denied");
    }
  }

  void _tabControllerListener() {
    final value = tabController.animation!.value.round();
    if (value == 5) {
      tabController.index = currentPage;
    } else if (value != currentPage) {
      changePage(value);
    }
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<bool> onDoubleTapBack(BuildContext context) async {
    final difference = DateTime.now().difference(backPressedTime);
    backPressedTime = DateTime.now();
    if (difference >= const Duration(seconds: 2)) {
      toast(context, "Click Again to Close App");
      return false;
    } else {
      SystemNavigator.pop(animated: true);
    }
    return true;
  }

  static toast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onDoubleTapBack(context),
      child: Scaffold(
        body: Stack(
          children: [
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Bottom_Bar(
      currentPage: currentPage,
      tabController: tabController,
      colors: [
        Palette.white,
        Palette.white,
        Palette.white,
        Palette.white,
        Palette.white,
      ],
      barColor: Palette.black,
      start: 20,
      end: 1,
      width: 280,
      icon: ImagePath.solarMagnifer,
      icon1: ImagePath.solarChat,
      icon2: ImagePath.solarHome,
      icon3: ImagePath.solarHeart,
      icon4: ImagePath.solarUser,
      child: TabBarView(
        controller: tabController,
        physics: const BouncingScrollPhysics(),
        children: [
          MapScreen(),
          Container(),
          HomePage(),
          Container(),
          Container(), 
        ],
      ),
    );
  }
}
