import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:realestate/Controller/service/fetchEstate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../Constants/theme/text_themes.dart';
import '../../Model/estate.dart';
import '../../constants/colors.dart';
import 'component/appbarContent.dart';
import 'component/circles _square.dart';
import 'component/gridView.dart';
import 'component/slideablecard.dart';
import 'component/textTransition.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<int> _numberAnimation;
  late Animation<int> _numbereAnimation;
  late Animation<Offset> _slideAnimation;
  late Future<List<Estate>> _gridDataFuture;
  bool _isAvatarExpanded = false;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isAvatarExpanded = true;
        isExpanded = true;
      });
    });

    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..forward();
    _gridDataFuture = Fetch.fetchGridDataFromServer();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _numberAnimation = IntTween(begin: 50, end: 1034).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _numbereAnimation = IntTween(begin: 50, end: 2212).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Palette.white, Palette.Orange],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppBarContent(),
                        SizedBox(height: 30),
                        FadeTransition(
                            opacity: _animation,
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text("Hi, Marina",
                                    style: TextThemes.whiteHeadline5))),
                        TextTransition(),
                        SizedBox(height: 30),
                        AnimatedCircleAndContainer(
                          animation: _animation,
                          numberAnimation: _numberAnimation,
                          numbereAnimation :_numbereAnimation,
                          isAvatarExpanded: _isAvatarExpanded,

                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                AnimatedGridView(
                  slideAnimation: _slideAnimation,
                  gridDataFuture: _gridDataFuture,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
