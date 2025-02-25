import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realestate/Constants/theme/text_themes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Constants/colors.dart';
import '../../../Constants/values.dart';

class SlidingCard extends StatefulWidget {
  final String location;
  final double width; // Add the width parameter

  const SlidingCard({super.key, required this.location, required this.width});

  @override
  _SlidingCardState createState() => _SlidingCardState();
}

class _SlidingCardState extends State<SlidingCard> {
  bool _isExpanded = false;
  bool isTextVisible = false;
  late final Future<void> delayedFuture;
  late final Future<void> delayedFu;

  @override
  void initState() {
    super.initState();
    // Automatically expand the container after a short delay when the screen loads
    delayedFu = Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isExpanded = true;
        });
      }
    });
    delayedFuture = Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          isTextVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    delayedFuture;
    delayedFu;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 9.0,
              sigmaY: 9.0,
            ),
          ),
          AnimatedContainer(
            duration: Duration(seconds: 4),
            width: _isExpanded ? widget.width : 50,
            // Use the passed width
            height: 50,
            curve: Curves.easeInOut,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Palette.black.withOpacity(0.25),
                      blurRadius: 30,
                      offset: Offset(2, 2))
                ],
                border: Border.all(color: Colors.transparent, width: 1.0),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Palette.white.withOpacity(0.5),
                      Palette.white.withOpacity(0.3),
                    ],
                    stops: [
                      0.0,
                      1.0,
                    ])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Container(
                        width: 100,
                        child: Text(
                          widget.location,
                          style: TextThemes.orangeButtonText,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedAlign(
                  alignment: _isExpanded
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Palette.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          ImagePath.solarArrowline,
                          color: Palette.deardGrey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
