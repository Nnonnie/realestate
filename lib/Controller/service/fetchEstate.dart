import 'package:flutter/material.dart';
import 'package:realestate/constants/values.dart';
import '../../Model/estate.dart';

class Fetch {
  static Future<List<Estate>> fetchGridDataFromServer() async {
    await Future.delayed(Duration(seconds: 1));

    List<Map<String, dynamic>> data = [
      {
        'image': ImagePath.checkout,
        'location': 'Gladkova St.,25',
      },
      {
        'image': ImagePath.housePick,
        'location': 'Trefoleva St.,43',
      },
      {
        'image': ImagePath.house,
        'location': 'Gubina St.,11',
      },
      {
        'image': ImagePath.houseSale,
        'location': 'Sedova St.,22',
      },
      {
        'image': ImagePath.pickMeHouse,
        'location': 'Houston,56',
      },
      {
        'image': ImagePath.housePlan,
        'location': 'San Francisco,17',
      },
    ];

    List<Estate> gridTiles =
    data.map((e) => Estate.fromMap(e)).toList();

    return gridTiles;
  }
}
