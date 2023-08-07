import 'package:flutter/material.dart';
import 'package:train/helper/constants.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with TickerProviderStateMixin {
  late AnimationController dot1Controller;
  late AnimationController dot2Controller;
  late AnimationController dot3Controller;

  late Animation<double> dot1Animation;
  late Animation<double> dot2Animation;
  late Animation<double> dot3Animation;
  final radius = 12.0;
  final minRadius = 3.0;
  final padding = 5.0;
  final duration = const Duration(milliseconds: 200);
  final curve=Curves.ease;

  @override
  void initState() {
    dot1Controller = AnimationController(vsync: this, duration: duration);
    dot2Controller = AnimationController(vsync: this, duration: duration);
    dot3Controller = AnimationController(vsync: this, duration: duration);

    dot1Animation =
        Tween<double>(begin: minRadius, end: radius).animate(CurvedAnimation(parent: dot1Controller, curve: curve));
    dot2Animation =
        Tween<double>(begin: minRadius, end: radius).animate(CurvedAnimation(parent: dot2Controller, curve: curve));
    dot3Animation =
        Tween<double>(begin: minRadius, end: radius).animate(CurvedAnimation(parent: dot3Controller, curve: curve));

    dot1Controller.forward();
    dot1Controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        dot1Controller.reverse();
        dot2Controller.forward();
      }
    });
    dot2Controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        dot2Controller.reverse();
        dot3Controller.forward();
      }
    });
    dot3Controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        dot3Controller.reverse();
        dot1Controller.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    dot1Controller.dispose();
    dot2Controller.dispose();
    dot3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color color = Colors.blueAccent;
    return Scaffold(
      body: Column(
        children: [
          sbh(200),
          SizedBox(
            height: 40,
            child: AnimatedBuilder(
              animation: Listenable.merge(
                  [dot1Controller, dot2Controller, dot3Controller]),
              builder: (context, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: padding),
                      width: radius + padding,
                      child: CircleAvatar(
                        radius: dot1Animation.value,
                        backgroundColor: color,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: padding),
                      width: radius + padding,
                      child: CircleAvatar(
                        radius: dot2Animation.value,
                        backgroundColor: color,
                      ),
                    ),
                    SizedBox(
                      width: radius,
                      child: CircleAvatar(
                        radius: dot3Animation.value,
                        backgroundColor: color,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
