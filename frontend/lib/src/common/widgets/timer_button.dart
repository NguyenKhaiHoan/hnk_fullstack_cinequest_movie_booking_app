import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/utils/timer_util.dart';
import 'package:flutter/material.dart';

class TimerButton extends StatelessWidget {
  const TimerButton({required this.width, super.key});

  final double width;

  @override
  Widget build(BuildContext context) {
    final timer = TimerUtil.getTimer(context);
    return CustomButton(
      width: width,
      text: timer,
      buttonType: ButtonType.outlined,
    );
  }
}
