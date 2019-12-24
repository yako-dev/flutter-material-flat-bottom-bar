import 'package:flutter/material.dart';

import 'screens/skeleton_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(91, 54, 183, 1),
      ),
      home: SkeletonScreen(),
    );
  }
}
