import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../Constants/theme/text_themes.dart';
import '../../../constants/values.dart';
import '../../../constants/colors.dart';

class AppBarContent extends StatefulWidget {
  @override
  _AppBarContentState createState() => _AppBarContentState();
}

class _AppBarContentState extends State<AppBarContent> {
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Animated Container Expanding Left to Right
        AnimatedContainer(
          decoration: BoxDecoration(
            color: Palette.white,
            borderRadius: BorderRadius.circular(10),

            boxShadow: [
              BoxShadow(
                color: Palette.deardGrey.withOpacity(0.2), // Shadow color
                blurRadius: 5, // Softness of the shadow
                offset: Offset(
                    0, 4), // Shadow direction (vertical and horizontal offset)
              ),
            ],

            // Apply the curved radius here
          ),

          duration: Duration(seconds: 5),
          width: _isContainerExpanded ? 185 : 10,
          height: 40,
          curve: Curves.easeInOut,
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
                    Icon(
                      Icons.location_on_sharp,
                      color: Palette.deardGrey,
                    ),
                    Expanded(
                      child: Container(
                        width: 150,
                        child: Text(
                          'Saint Petersburg',
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
        AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
          width: _isAvatarExpanded ? 50 : 30,
          height: _isAvatarExpanded ? 50 : 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage(ImagePath.profile2),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
