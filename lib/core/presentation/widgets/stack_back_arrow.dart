import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:series_spot/core/presentation/routes/my_navigator.dart';
import 'package:series_spot/core/utils/colors.dart';

class StackBackArrow extends StatelessWidget {
  const StackBackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 4,
      left: 4,
      child: IconButton(
        onPressed: () => MyNavigator(context).pop(),
        icon: Container(
          decoration: BoxDecoration(
            color: AppColors.containerBackground.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(4),
          width: 36,
          height: 36,
          child: Icon(
            Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
