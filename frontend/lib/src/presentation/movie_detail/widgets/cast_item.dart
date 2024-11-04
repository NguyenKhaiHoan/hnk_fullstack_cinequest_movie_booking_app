import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_url.dart';
import 'package:flutter/material.dart';

class CastItem extends StatelessWidget {
  const CastItem({
    required this.profilePath,
    required this.originalName,
    required this.character,
    required this.hasLeftSpace,
    super.key,
  });

  final String profilePath;
  final String originalName;
  final String character;
  final bool hasLeftSpace;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(color: AppColors.eerieBlack),
        ),
      ),
      padding: hasLeftSpace
          ? const EdgeInsets.symmetric(horizontal: 16)
          : const EdgeInsets.only(right: 16),
      child: Center(
        child: Column(
          children: [
            _buildProfileImage(),
            gapH8,
            _buildName(),
            gapH8,
            _buildCharacter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(TMDBUrl.imageBaseUrl + profilePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildName() {
    return Text(
      originalName,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildCharacter(BuildContext context) {
    return Text(
      character,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.textTheme.bodyMedium!.copyWith(color: AppColors.dimGray),
    );
  }
}
