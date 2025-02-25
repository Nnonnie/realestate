import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:realestate/Constants/bubbleHelp/bubbleInfor.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Constants/bubbleHelp/options.dart';
import '../../../Constants/theme/text_themes.dart';
import '../../../constants/values.dart';
import '../../../constants/colors.dart';

class BottomFLoatingContainer extends StatefulWidget {
  const BottomFLoatingContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomFLoatingContainer> createState() =>
      _BottomFLoatingContainerState();
}

class _BottomFLoatingContainerState extends State<BottomFLoatingContainer> {
  bool _isContainerExpanded = false;
  bool _isAvatarExpanded = false;
  bool isTextVisible = false;
  final GlobalKey focusableWidgetKey = GlobalKey();
  int content = 0;

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

  showInfoBubble(
    Widget title,
    GlobalKey focusableWidgetKey,
    Color bgColor, {
    required List<Map<String, dynamic>> options, // Dynamic list of options
    required void Function(int) onContentChanged, // callback to update content
    required int content,
    double bubbleWidth = 185.0,
    double bubblePadding = 32.0,
    double bubbleTipWidth = 22.0,
    double bubbleTipHeight = 12.0,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final BuildContext? context = focusableWidgetKey.currentContext;

      if (context == null) {
        print("Error: The context is null.");
        return;
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return InfoBubbleDialogWidget(focusableWidgetKey, bgColor,
                bubbleWidth: bubbleWidth,
                bubblePadding: bubblePadding,
                bubbleTipWidth: bubbleTipWidth,
                bubbleTipHeight: bubbleTipHeight,
                onContentChanged: onContentChanged,
                content: content,

                options: options);
          });
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 100, // adjust the vertical positioning as needed
          right: 20, // adjust the horizontal positioning as needed
          child: AnimatedContainer(
            decoration: BoxDecoration(
              color: Palette.white.withOpacity(0.4),
              borderRadius:
                  BorderRadius.circular(20), // Apply the curved radius here
            ),
            duration: Duration(seconds: 2),
            width: _isContainerExpanded ? 150 : 10,
            // Animating width
            height: 40,

            curve: Curves.easeInOut,
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
                          ImagePath.solarListOutline,
                          color: Palette.white, // Icon color
                        ),
                      ),
                      Text("List of variants")
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 150, // Adjust for spacing
          left: 20, // Same horizontal position as the button
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            width: _isAvatarExpanded ? 45 : 10,
            // Animating the avatar size
            height: _isAvatarExpanded ? 45 : 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Palette.white.withOpacity(0.4),
            ),
            child: InkWell(
              key: focusableWidgetKey,
              onTap: () {
                showInfoBubble(
                  Column(
                    children: [
                      // The title widget dynamically updates based on content
                      Text(
                        content == 3
                            ? "Cosy areas"
                            : content == 2
                                ? "Price"
                                : content == 1
                                    ? "Infrastructure"
                                    : "Without any layer",
                        style: content == 3
                            ? TextThemes.OrangeTextText
                            : content == 2
                                ? TextThemes.OrangeTextText
                                : content == 1
                                    ? TextThemes.OrangeTextText
                                    : TextThemes.greyTextText,
                      ),
                    ],
                  ),
                  focusableWidgetKey,
                  Palette.beige,
                  onContentChanged: (int newContent) {
                    setState(() {
                      content = newContent;
                    });
                    print(content);
                  },
                  content: content,
                  options: options,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: content == 0
                    ? SvgPicture.asset(
                        ImagePath.solarLayerline,
                        color: Palette.white,
                      )
                    : (content == 1)
                        ? SvgPicture.asset(
                            ImagePath.solarinfras,
                            color: Palette.white,
                          )
                        : (content == 2)
                            ? SvgPicture.asset(
                                ImagePath.solarWallet,
                                color: Palette.white,
                              )
                            : SvgPicture.asset(
                                ImagePath.solarShield,
                                color: Palette.white,
                              ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 100, // Adjust for spacing
          left: 20, // Same horizontal position as the button
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            width: _isAvatarExpanded ? 45 : 10,
            // Animating the avatar size
            height: _isAvatarExpanded ? 45 : 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Palette.white.withOpacity(0.4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                ImagePath.solarSendline,
                color: Palette.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
