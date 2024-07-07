import 'package:flutter/material.dart';
import 'package:series_spot/core/utils/images.dart';

class BlurBackground extends StatelessWidget {
  const BlurBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        Image.asset(
          Images.background,
          width: screenSize.width,
          fit: BoxFit.fill,
        ),
        child,
      ],
    );
  }
}
