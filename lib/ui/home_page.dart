import 'package:coolAnimations/const/route_const.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            color: Colors.blue,
            child: const Text("三阶贝塞尔曲线动画"),
            onPressed: () {
              Navigator.of(context).pushNamed(RouteConst.thirdBezier);
            },
          )
        ],
      ),
    );
  }
}
