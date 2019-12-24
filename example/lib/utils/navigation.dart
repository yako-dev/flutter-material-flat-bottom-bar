import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation {
  static Future<dynamic> toScreen(
    BuildContext context,
    Widget screen, {
    rootNavigator = false,
  }) {
    return Navigator.of(context, rootNavigator: rootNavigator).push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }
}
