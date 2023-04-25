import 'package:flutter/material.dart';

import 'screens/add_manga.dart';
import 'screens/screens_holder.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreensHolder(),
    );
  }
}