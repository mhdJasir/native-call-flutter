import 'dart:math';

import 'package:flutter/material.dart';

class ThreeDCube extends StatefulWidget {
  const ThreeDCube({Key? key}) : super(key: key);

  @override
  State<ThreeDCube> createState() => _ThreeDCubeState();
}

class _ThreeDCubeState extends State<ThreeDCube> with TickerProviderStateMixin {
  late AnimationController xController;
  late AnimationController yController;
  late AnimationController zController;
  late Tween<double> animation;

  @override
  void initState() {
    xController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    yController =
        AnimationController(vsync: this, duration: const Duration(seconds: 30));
    zController =
        AnimationController(vsync: this, duration: const Duration(seconds: 40));
    animation = Tween<double>(begin: 0, end: pi * 2);
    super.initState();
  }

  @override
  void dispose() {
    xController.dispose();
    yController.dispose();
    zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    xController
      ..reset()
      ..repeat();
    yController
      ..reset()
      ..repeat();
    zController
      ..reset()
      ..repeat();
    const side = 120.0;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 200,
          ),
          Center(
            child: AnimatedBuilder(
              animation:
                  Listenable.merge([xController, yController, zController]),
              builder: (context, _) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateX(animation.evaluate(xController))
                    ..rotateY(animation.evaluate(yController))
                    ..rotateZ(animation.evaluate(zController)),
                  child: Stack(
                    children: [
                      Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()..rotateY(pi / 2),
                        child: Container(
                          height: side,
                          width: side,
                          color: Colors.yellow,
                        ),
                      ),
                      Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()..rotateY(-(pi / 2)),
                        child: Container(
                          height: side,
                          width: side,
                          color: Colors.pink,
                        ),
                      ),
                      Transform(
                        alignment: Alignment.topCenter,
                        transform: Matrix4.identity()..rotateX(-(pi / 2)),
                        child: Container(
                          height: side,
                          width: side,
                          color: Colors.green,
                        ),
                      ),
                      Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()..rotateX((pi / 2)),
                        child: Container(
                          height: side,
                          width: side,
                          color: Colors.blue,
                        ),
                      ),
                      Container(
                        height: side,
                        width: side,
                        color: Colors.red,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
