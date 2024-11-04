import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

part '_mixins/finding_location_page.mixin.dart';

class FindingLocationPage extends StatelessWidget {
  const FindingLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _Page();
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
      body: Center(
        child: _buildAnimation(),
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
            width: 300,
            height: 300,
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
