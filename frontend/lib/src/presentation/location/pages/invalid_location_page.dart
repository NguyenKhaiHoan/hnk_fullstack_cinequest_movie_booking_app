import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/blocs/app/app_bloc.dart';
import 'package:cinequest/src/common/blocs/buttton/button_bloc.dart';
import 'package:cinequest/src/common/blocs/location/location_bloc.dart';
import 'package:cinequest/src/common/constants/app_constant.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/service/location_stream_service.dart';
import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/ui_util.dart';
import 'package:cinequest/src/external/services/location/location_service.dart';
import 'package:cinequest/src/presentation/location/widgets/reset_location_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart';

part '_mixins/invalid_location_page.mixin.dart';

class InvalidLocationPage extends StatelessWidget {
  const InvalidLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocationBloc(
            locationStreamService: sl(),
          ),
        ),
        BlocProvider(
          create: (context) => ButtonBloc(),
        ),
      ],
      child: const _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  const _Page();

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> with _PageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Center(
              child: _buildAnimation(),
            ),
          ),
          _buildDescription(context),
          gapH24,
          ResetLocationButton(
            listenerResetLocationButton: _listenerResetLocationButton,
            resetLocation: _resetLocation,
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
      child: Text(
        'Currently, we only serve within Hanoi City. Please reset your location.'
            .hardcoded,
        style: context.textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAnimation() {
    return FutureBuilder<LottieComposition>(
      future: _composition,
      builder: (context, snapshot) {
        final composition = snapshot.data;
        if (composition != null) {
          return Lottie(
            composition: composition,
            width: UiUtil.deviceWidth - AppSizes.defaultSpace * 2,
            fit: BoxFit.cover,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.white,
            ),
          );
        }
      },
    );
  }
}
