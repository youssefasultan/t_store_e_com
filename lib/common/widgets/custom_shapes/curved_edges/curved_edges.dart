import 'package:flutter/material.dart';

class CustomCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstCurvePoint = Offset(0, size.height - 20);
    final lastCurvePoint = Offset(30, size.height - 20);

    path.quadraticBezierTo(
      firstCurvePoint.dx,
      firstCurvePoint.dy,
      lastCurvePoint.dx,
      lastCurvePoint.dy,
    );

    final firstlinePoint = Offset(0, size.height - 20);
    final lastlinePoint = Offset(size.width - 30, size.height - 20);

    path.quadraticBezierTo(
      firstlinePoint.dx,
      firstlinePoint.dy,
      lastlinePoint.dx,
      lastlinePoint.dy,
    );

    final secondFirstCurvePoint = Offset(size.width, size.height - 20);
    final secondLastCurvePoint = Offset(size.width, size.height);

    path.quadraticBezierTo(
      secondFirstCurvePoint.dx,
      secondFirstCurvePoint.dy,
      secondLastCurvePoint.dx,
      secondLastCurvePoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
