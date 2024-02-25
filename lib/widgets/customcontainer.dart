import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  double? width;
  double? height;
  Widget? child;
  Decoration? decoration;
  CustomContainer({
    required this.height,
    required this.decoration,
    required this.width,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: child,
      decoration: decoration
    );
  }
}
