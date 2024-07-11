import 'package:flutter/material.dart';
import 'package:train/helper/constants.dart';
import 'package:train/widgets/field_widget.dart';
import 'package:train/widgets/overlay_composite_widget.dart';

class CustomWidget extends StatefulWidget {
  const CustomWidget({super.key});

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 200,
              child: OverlayCompositeWidget(
                menuHeight: 60,
                menuWidth: 250,
                alignedPositionMargin: -100,
                topMargin: -20,
                borderRadius: 2,
                overlayWidget: (closFn) {
                  return LayoutBuilder(builder: (context, con) {
                    return buildCustomPaint();
                  });
                },
                builder: (closeFn) {
                  return const SizedBox(
                    height: 40,
                    width: 200,
                    child: Text("Click"),
                  );
                },
              ),
            ),
          ),
          sbh(100),
          Center(
            child: buildCustomPaint(),
          )
        ],
      ),
    );
  }

  Widget buildCustomPaint() {
    return CustomPaint(
      painter: PointerShape(),
      child: Container(
        height: 60,
        width: 250,
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Discount",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              sbw(5),
              const Expanded(
                child: Field(),
              ),
              sbw(5),
              const Expanded(
                child: Field(),
              ),
              sbw(5),
              const Text("%")
            ],
          ),
        ),
      ),
    );
  }
}

class PointerShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const pointerMargin = 12.0;
    const pointerHeight = 10.0;
    final Paint paint = Paint()
      ..color = Colors.grey
      // ..color = const Color(0xffFFFFFF)
      ..style = PaintingStyle.stroke;
    const double borderRadius = 5.0;
    const radius = Radius.circular(borderRadius);

    Path path = Path()
      ..moveTo(0 + borderRadius, pointerHeight)
      ..lineTo(pointerMargin, pointerHeight)
      ..lineTo(pointerMargin + pointerHeight, 0)
      ..lineTo(pointerMargin + pointerHeight * 2, pointerHeight)
      ..lineTo(size.width - borderRadius, pointerHeight)
      ..arcToPoint(
        Offset(size.width, pointerHeight + borderRadius),
        radius: radius,
      )
      ..lineTo(size.width, size.height - borderRadius)
      ..arcToPoint(
        Offset(size.width - borderRadius, size.height),
        radius: radius,
      )
      ..lineTo(borderRadius, size.height)
      ..arcToPoint(
        Offset(0, size.height - borderRadius),
        radius: radius,
      )
      ..lineTo(0, pointerHeight + borderRadius)
      ..arcToPoint(
        const Offset(0 + borderRadius, pointerHeight),
        radius: radius,
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
