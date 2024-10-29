import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/blocs/location/location_bloc.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetLocationButton extends StatelessWidget {
  const ResetLocationButton({
    required this.listenerResetLocationButton,
    super.key,
    this.resetLocation,
  });

  final void Function(BuildContext context, LocationState state)
      listenerResetLocationButton;
  final void Function()? resetLocation;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: listenerResetLocationButton,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(
            vertical: AppSizes.defaultSpace,
            horizontal: AppSizes.defaultSpace,
          ),
          child: CustomButton(
            isLoading: state == const LocationState.loading(),
            width: double.infinity,
            text: 'Reset location'.hardcoded,
            textColor: AppColors.black,
            buttonType: ButtonType.elevated,
            onPressed: resetLocation,
          ),
        );
      },
    );
  }
}
