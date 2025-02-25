import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:realestate/Model/address.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Constants/theme/text_themes.dart';
import '../../../constants/values.dart';
import '../../../constants/colors.dart';

class SearchAppBar extends StatefulWidget {
  final Address location;

  const SearchAppBar({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool _isContainerExpanded = false;
  bool _isAvatarExpanded = false;
  bool isTextVisible = false;

  @override
  void initState() {
    super.initState();

    // First animate container expansion after the widget is rendered
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _isContainerExpanded = true;
      });

      // After container animation completes, start avatar animation
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _isAvatarExpanded = true;
        });
      });
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isTextVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 150,
        ),
        // Animated Container Expanding Left to Right
        AnimatedContainer(
          decoration: BoxDecoration(
            color: Palette.white,
            borderRadius:
                BorderRadius.circular(20), // Apply the curved radius here
          ),

          duration: Duration(seconds: 5),
          width: _isContainerExpanded ? 250 : 10,
          height: 40,
          curve: Curves.easeIn,
          //  alignment: Alignment.center,
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedOpacity(
              opacity: _isContainerExpanded ? 1 : 0,
              duration: Duration(seconds: 1),
              child: Visibility(
                visible: isTextVisible,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: SvgPicture.asset(
                        ImagePath.solarMagOutline,
                        color: Palette.deardGrey, // Keep the icon color white
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 150,
                        child: Text(
                          (widget.location.street.toString() != "Unknown" ||
                                  widget.location.street.toString() != "null")
                              ? widget.location.country.toString()
                              : "Saint Petersburg",
                          style: TextThemes.whiteButtonText,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 30,
        ),
        AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
          width: _isAvatarExpanded ? 40 : 10,
          height: _isAvatarExpanded ? 40 : 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              ImagePath.solarMenuline,
              color: Palette.deardGrey,
            ),
          ),
        ),
      ],
    );
  }
}
