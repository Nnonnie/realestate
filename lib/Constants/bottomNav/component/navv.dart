import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realestate/Constants/colors.dart';
import 'inhertedData.dart';

class Bottom_Bar extends StatefulWidget {
  final Widget child;
  int currentPage;
  final TabController tabController;
  final List<Color> colors;
  final Color barColor;
  final double end;
  final double start;
  final double width;
  final String icon;
  final String icon1;
  final String icon2;
  final String icon3;
  final String icon4;

  Bottom_Bar({
    required this.child,
    required this.currentPage,
    required this.tabController,
    required this.colors,
    required this.barColor,
    required this.end,
    required this.start,
    Key? key,
    required this.width,
    required this.icon,
    required this.icon1,
    required this.icon2,
    required this.icon3,
    required this.icon4,
  }) : super(key: key);

  @override
  _Bottom_BarState createState() => _Bottom_BarState();
}

class _Bottom_BarState extends State<Bottom_Bar>
    with SingleTickerProviderStateMixin {
  ScrollController scrollBottom_BarController = ScrollController();
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool isScrollingDown = false;
  bool isOnTop = true;
  bool closeButton = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    // Set the animation to start off the screen (below) and slide up
    _offsetAnimation = Tween<Offset>(begin: Offset(0, 2), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    Future.delayed(Duration(seconds: 7), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  void showBottom_Bar() {
    if (mounted) {
      setState(() {
        _controller.forward();
      });
    }
  }

  void hideBottom_Bar() {
    if (mounted) {
      setState(() {
        _controller.reverse();
      });
    }
  }

  Future<void> myScroll() async {
    scrollBottom_BarController.addListener(() {
      if (scrollBottom_BarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          isOnTop = false;
          hideBottom_Bar();
        }
      }
      if (scrollBottom_BarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          isOnTop = true;
          showBottom_Bar();
        }
      }
    });
  }

  @override
  void dispose() {
    scrollBottom_BarController.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: [
        InheritedDataProvider(
          scrollController: scrollBottom_BarController,
          child: widget.child,
        ),
        Positioned(

          bottom: widget.start,
          child: SlideTransition(
            position: _offsetAnimation,
            child: ClipRRect(

              borderRadius: BorderRadius.circular(50),
              child: Container(

                height: 60, // Adjusted height for better appearance
                width: widget.width,
                decoration: BoxDecoration(
                  color: widget.barColor,
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Palette.Orange,
                    shape: BoxShape.circle,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: widget.tabController,
                  onTap: (index) {
                    setState(() {
                      widget.currentPage = index;
                    });
                  },
                  tabs: [
                    _buildTab(widget.icon, 0),
                    _buildTab(widget.icon1, 1),
                    _buildTab(widget.icon2, 2),
                    _buildTab(widget.icon3, 3),
                    _buildTab(widget.icon4, 4),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String icon, int index) {
    return Center(
      child: SvgPicture.asset(
        icon,
        color: Palette.white, // Keep the icon color white
      ),
    );
  }
}
