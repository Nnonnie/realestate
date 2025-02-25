import 'package:flutter/material.dart';
import 'Constants/bottomNav/navigator.dart';
import 'Constants/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RealEstate',
      theme: AppTheme.thema,
      home: BottomNav(),
    );
  }
}
