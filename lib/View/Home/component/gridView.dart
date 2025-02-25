import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:realestate/View/Home/component/slideablecard.dart';

import '../../../Model/estate.dart';
import '../../../constants/colors.dart';

class AnimatedGridView extends StatelessWidget {
  final Animation<Offset> _slideAnimation;
  final Future<List<Estate>> _gridDataFuture;

  // Constructor
  AnimatedGridView({
    required Animation<Offset> slideAnimation,
    required Future<List<Estate>> gridDataFuture,
  })  : _slideAnimation = slideAnimation,
        _gridDataFuture = gridDataFuture;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FutureBuilder<List<Estate>>(
        future: _gridDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Palette.Orange,));
          } else if (snapshot.hasError) {
            // Handle error
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Estate> gridData = snapshot.data!;

            return Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Palette.white,
                borderRadius:
                    BorderRadius.circular(15), // Apply the curved radius here
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverQuiltedGridDelegate(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 2,
                  pattern: [
                    QuiltedGridTile(1, 2),
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 2),
                  ],
                ),
                itemCount: gridData.length,
                itemBuilder: (context, index) {
                  Estate tile = gridData[index];

                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            tile.image,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            right: 10,
                            child: SlidingCard(
                                location: tile.location,
                                width: _getSlidingCardWidth(index, context)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  double _getSlidingCardWidth(int index, BuildContext context) {
    List<QuiltedGridTile> pattern = [
      QuiltedGridTile(1, 2), // 1 column, 2 rows
      QuiltedGridTile(1, 1), // 1 column, 1 row
      QuiltedGridTile(1, 1), // 1 column, 1 row
      QuiltedGridTile(1, 2), // 1 column, 2 rows
    ];

    int span = pattern[index % pattern.length].crossAxisCount;

    double screenWidth = MediaQuery.of(context).size.width;

    if (span == 1) {
      return screenWidth / 2 - 20;
    } else {
      return screenWidth - 70;
    }
  }
}
