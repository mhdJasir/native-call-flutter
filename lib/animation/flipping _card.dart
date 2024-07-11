import 'dart:math';

import 'package:flutter/material.dart';
import 'package:train/helper/constants.dart';

class FlippingCard extends StatefulWidget {
  const FlippingCard({Key? key}) : super(key: key);

  @override
  State<FlippingCard> createState() => _FlippingCardState();
}

class _FlippingCardState extends State<FlippingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: controller.value, end: 2*pi).animate(controller);
    controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sbh(100),
          Center(
            child: AnimatedBuilder(
                animation: animation,
                builder: (context, _) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateX(animation.value),
                    child: ClipOval(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.blue,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: double.infinity,
                                color: Colors.yellow,
                              ),
                            ),
                          ],
                        ),
                      ),
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
