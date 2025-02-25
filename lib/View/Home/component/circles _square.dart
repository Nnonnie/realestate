import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:realestate/constants/colors.dart';

import '../../../Constants/theme/text_themes.dart';

class AnimatedCircleAndContainer extends StatefulWidget {
  final Animation<double> _animation;
  final Animation<int> _numberAnimation;
  final Animation<int> _numbereAnimation;
  final bool _isAvatarExpanded;

  AnimatedCircleAndContainer({
    required Animation<double> animation,
    required Animation<int> numberAnimation,
    required bool isAvatarExpanded,
    required Animation<int> numbereAnimation,
  })  : _animation = animation,
        _numberAnimation = numberAnimation,
        _numbereAnimation = numbereAnimation,
        _isAvatarExpanded = isAvatarExpanded;

  @override
  State<AnimatedCircleAndContainer> createState() =>
      _AnimatedCircleAndContainerState();

}

class _AnimatedCircleAndContainerState
    extends State<AnimatedCircleAndContainer> {
  bool isTextVisible = false;

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isTextVisible = true;
      });
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Circle with number animation
        FadeTransition(
          opacity: widget._animation, // Fade animation for the circle
          child: AnimatedContainer(
            height: widget._isAvatarExpanded ? 170 : 50,
            width: widget._isAvatarExpanded ? 170 : 50,
            decoration: BoxDecoration(
              color: Palette.Orange,
              borderRadius:
                  BorderRadius.circular(100), // Apply the curved radius here
            ),
            duration: Duration(seconds: 1),
            child: AnimatedBuilder(
              animation: widget._numberAnimation,
              builder: (context, child) {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    Expanded(
                      child: Text("BUY", style: TextThemes.whiteSubtitle1),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      // This will make sure this widget takes up remaining space
                      child: Text(widget._numberAnimation.value.toString(),
                          style: TextThemes.whiteWeightline5),
                    ),
                    Expanded(
                      child: Text("offers", style: TextThemes.whiteSubtitle1),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        SizedBox(width: 5),

        FadeTransition(
          opacity: widget._animation,
          // Fade animation for the curved container
          child: AnimatedContainer(
            height: widget._isAvatarExpanded ? 150 : 50,
            width: widget._isAvatarExpanded ? 160 : 50,
            decoration: BoxDecoration(
              color: Palette.white,
              borderRadius:
                  BorderRadius.circular(20), // Apply the curved radius here
            ),
            curve: Curves.easeInOut,
            duration: Duration(seconds: 1),
            child: AnimatedBuilder(
              animation: widget._numbereAnimation,
              builder: (context, child) {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    Expanded(
                      child: Text("RENT", style: TextThemes.whiteButtonText),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Text(widget._numbereAnimation.value.toString(),
                          style: TextThemes.greyBigWeightline5),
                    ),
                    Expanded(
                      child: Text("offers", style: TextThemes.whiteButtonText),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
