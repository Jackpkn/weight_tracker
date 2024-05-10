import 'package:flutter/material.dart';

class GlobalContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final Color color;
  final double borderWidth;
  final BorderRadiusGeometry? borderRadius;
  const GlobalContainer({
    super.key,
    required this.child,
    required this.height,
    required this.width,
    required this.color,
    required this.borderWidth,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          width: borderWidth,
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}
