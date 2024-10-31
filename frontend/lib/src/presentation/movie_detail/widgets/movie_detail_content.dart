import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({
    required this.releaseDate,
    required this.runtime,
    required this.originCountry,
    required this.voteAverage,
    required this.title,
    required this.overview,
    required this.genres,
    super.key,
  });

  final String releaseDate;
  final String runtime;
  final String originCountry;
  final String voteAverage;
  final String title;
  final String overview;
  final String genres;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$releaseDate   ·   $runtime   ·   $originCountry   ·   ★ $voteAverage'
              .toUpperCase(),
          style:
              context.textTheme.bodySmall!.copyWith(color: AppColors.dimGray),
        ),
        gapH32,
        Text(
          title,
          style: context.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        gapH32,
        Text(
          overview,
          textAlign: TextAlign.center,
        ),
        gapH32,
        Text(
          genres.toUpperCase(),
          style:
              context.textTheme.bodySmall!.copyWith(color: AppColors.dimGray),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
