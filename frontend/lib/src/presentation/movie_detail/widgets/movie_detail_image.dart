import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/common/widgets/tickets_button.dart';
import 'package:cinequest/src/core/utils/ui_util.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_url.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieDetailImage extends StatelessWidget {
  const MovieDetailImage({required this.backdropPath, super.key});

  final String backdropPath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: UiUtil.deviceHeight * 2 / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusXl),
            color: AppColors.eerieBlack,
            image: DecorationImage(
              image: NetworkImage(
                TMDBUrl.imageBaseUrl + backdropPath,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: AppSizes.defaultSpace,
          right: AppSizes.defaultSpace,
          left: AppSizes.defaultSpace,
          child: Row(
            children: [
              const TicketsButton(),
              gapW8,
              const Spacer(),
              CustomCircleButton(
                iconPath: AppAssets.images.export.path,
                onPressed: () => context.pop(),
                backgroundColor: AppColors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
