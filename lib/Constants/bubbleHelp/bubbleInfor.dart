import 'dart:async';
import 'package:flutter/material.dart';
import 'package:realestate/Constants/bubbleHelp/gloabalPaintBond.dart';
import 'package:realestate/Constants/bubbleHelp/trangularComponent.dart';
import 'package:realestate/Constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/text_themes.dart';
import 'options.dart';

class InfoBubbleDialogWidget extends StatefulWidget {
  final GlobalKey focusableWidgetKey;
  final Color bgColor;
  final double bubbleWidth;
  final double bubblePadding;
  final double bubbleTipWidth;
  final double bubbleTipHeight;
  final void Function(int) onContentChanged;
  final int content; // hold the content state
  final List<Map<String, dynamic>> options;

  const InfoBubbleDialogWidget(
    this.focusableWidgetKey,
    this.bgColor, {
    super.key,
    required this.bubbleWidth,
    required this.onContentChanged,
    required this.content,
    required this.options,
    required this.bubblePadding,
    required this.bubbleTipWidth,
    required this.bubbleTipHeight,
  });

  @override
  State<InfoBubbleDialogWidget> createState() => InfoBubbleDialogWidgetState();
}

class InfoBubbleDialogWidgetState extends State<InfoBubbleDialogWidget> {
  double bubbleTipLeftPadding = 0.0;
  int? currentContent;
  double? leftPosition;
  double? rightPosition;
  double? topPosition;
  double? bottomPosition;
  Rect? widgetConstraints;
  late bool showBubbleAboveWidget;
  late bool showBubbleLeftWidget;
  late double bubbleTipHalfWidth;
  var animationTopHeight = 0.0;
  var animationBottomHeight = 0.0;
  final animationDuration = const Duration(milliseconds: 200);
  final animationVerticalMotionHeight = 4.0;
  Timer? animationTimer;

  double get screenWidth =>
      MediaQuery.of(widget.focusableWidgetKey.currentContext!).size.width;

  double get screenHeight =>
      MediaQuery.of(widget.focusableWidgetKey.currentContext!).size.height;

  animateBubble() {
    if (animationTopHeight == 0) {
      animationTopHeight = animationVerticalMotionHeight;
      animationBottomHeight = animationVerticalMotionHeight;
    } else {
      animationTopHeight = 0;
      animationBottomHeight = 0;
    }
    setState(() {});
  }

  initBubblePosition() {
    widgetConstraints = widget.focusableWidgetKey.globalPaintBounds;
    var bubbleTipHalfWidth = widget.bubbleTipWidth / 2;
    var screenYCenter = screenHeight / 2;
    var screenXCenter = screenWidth / 2;
    var widgetLeft = widgetConstraints?.left ?? 0;
    var widgetTop = widgetConstraints?.top ?? 0;
    var widgetRight = widgetConstraints?.right ?? 0;
    var widgetCenterX = widgetLeft + ((widgetRight - widgetLeft) / 2);

    showBubbleAboveWidget = widgetTop > screenYCenter;
    showBubbleLeftWidget = widgetLeft < screenXCenter;

    if (showBubbleLeftWidget) {
      leftPosition = widget.bubblePadding;
    } else {
      rightPosition = widget.bubblePadding;
    }

    if (showBubbleAboveWidget) {
      bottomPosition = screenHeight - widgetTop;
    } else {
      topPosition = widgetTop;
    }

    if (showBubbleLeftWidget) {
      bubbleTipLeftPadding =
          widgetCenterX - widget.bubblePadding - bubbleTipHalfWidth;

      ///If widget is very close to screen.
      if (bubbleTipLeftPadding < 0) bubbleTipLeftPadding = 0;
    } else {
      var widgetLeft = screenWidth - widget.bubbleWidth - widget.bubblePadding;
      bubbleTipLeftPadding = widgetCenterX - widgetLeft - bubbleTipHalfWidth;

      ///If widget is very close to screen.
      if (bubbleTipLeftPadding > widget.bubbleWidth - widget.bubbleTipWidth) {
        bubbleTipLeftPadding = widget.bubbleWidth - widget.bubbleTipWidth;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initBubblePosition();

    ///Initialize animation
    Future.delayed(const Duration(milliseconds: 100)).then(
      (value) => animateBubble(),
    );
    animationTimer = Timer.periodic(animationDuration, (_) => animateBubble());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: animationDuration,
          left: leftPosition,
          right: rightPosition,
          top: topPosition != null ? topPosition! + animationTopHeight : null,
          bottom: bottomPosition != null
              ? bottomPosition! + animationBottomHeight
              : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!showBubbleAboveWidget)
                Padding(
                  padding: EdgeInsets.only(left: bubbleTipLeftPadding),
                  child: CustomPaint(
                    painter: TrianglePainter(
                      strokeColor: Palette.transparant,
                      strokeWidth: 10,
                      paintingStyle: PaintingStyle.fill,
                    ),
                    child: SizedBox(
                      height: widget.bubbleTipHeight,
                      width: widget.bubbleTipWidth,
                    ),
                  ),
                ),
              Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  width: widget.bubbleWidth,
                  decoration: BoxDecoration(
                    color: widget.bgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          // The dynamic title widget that depends on content

                          // Create the dynamic list of options
                          ...options.map((option) {
                            return InkWell(
                              onTap: () {
                                widget.onContentChanged(option['value']);
                                print(widget.onContentChanged);// Update content state based on option value
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8, bottom: 8,top:8),
                                    child: SvgPicture.asset(
                                      option['icon'],
                                      color: widget.content == option['value']
                                          ? Palette.Orange
                                          : Palette
                                              .deardGrey,
                                    ),
                                  ),
                                  Text(
                                    option['title'],
                                    style: widget.content == option['value']
                                        ? TextThemes.OrangeTextText
                                        : TextThemes.greyTextText,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          // Map over options and create each InkWell dynamically
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              if (showBubbleAboveWidget)
                Padding(
                  padding: EdgeInsets.only(left: bubbleTipLeftPadding),
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: CustomPaint(
                      painter: TrianglePainter(
                        strokeColor: Palette.transparant,
                        strokeWidth: 10,
                        paintingStyle: PaintingStyle.fill,
                      ),
                      child: SizedBox(
                        height: widget.bubbleTipHeight,
                        width: widget.bubbleTipWidth,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    animationTimer?.cancel();
    super.dispose();
  }
}
