
import 'package:flutter/material.dart';

import '../ui/home_page.dart';
import '../ui/third_bezier_page.dart';

class RouteConst {

  RouteConst._();

  static const home = "home";
  static const thirdBezier = "thirdBezier";

  static final routes = <String, WidgetBuilder>{
    home : (context) {
      return const HomePage();
    },
    thirdBezier : (context) {
      return const ThirdBezierPage();
    }
  };
}