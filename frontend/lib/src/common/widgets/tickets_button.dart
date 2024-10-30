import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

class TicketsButton extends StatelessWidget {
  const TicketsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      buttonType: ButtonType.elevated,
      text: 'Tickets'.toUpperCase().hardcoded,
      textColor: AppColors.black,
    );
  }
}
