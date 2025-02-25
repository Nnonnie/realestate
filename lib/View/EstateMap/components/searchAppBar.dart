import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Constants/theme/text_themes.dart';
import '../../../constants/values.dart';
import '../../../constants/colors.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool isContainerExpanded = false;
  bool isAvatarExpanded = false;
  bool isTextVisible = false;
  late final Future<void> delayedFuture;
  late final Future<void> delayedFu;
  late final Future<void> delayedFufu;

  @override
  void initState() {
    super.initState();

    // First animate container expansion after the widget is rendered
    if (mounted) {
      delayedFu = Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          isContainerExpanded = true;
        });

        // After container animation completes, start avatar animation
        delayedFuture = Future.delayed(Duration(seconds: 1), () {
          setState(() {
            isAvatarExpanded = true;
          });
        });
      });
    }
    if (mounted) {
      delayedFufu = Future.delayed(Duration(seconds: 5), () {
        setState(() {
          isTextVisible = true;
        });
      });
    }
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

          duration: Duration(seconds: 2),
          width: isContainerExpanded ? 250 : 10,
          height: 40,
          curve: Curves.easeInOutExpo,
          //  alignment: Alignment.center,
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedOpacity(
              opacity: isContainerExpanded ? 1 : 0,
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
                          "Saint Petersburg",
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
          width: isAvatarExpanded ? 40 : 10,
          height: isAvatarExpanded ? 40 : 10,
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
