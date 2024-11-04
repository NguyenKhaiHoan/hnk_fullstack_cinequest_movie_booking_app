import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/domain/movie/entities/crew.dart';
import 'package:flutter/material.dart';

class CrewItem extends StatelessWidget {
  const CrewItem({required this.crew, super.key, required this.crews});

  final Crew crew;
  final List<Crew> crews;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: _getItemDecoration(crew),
      child: Padding(
        padding: _getItemPadding(crew),
        child: Text(
          crew.originalName ?? '',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: context.textTheme.bodyMedium,
        ),
      ),
    );
  }

  BoxDecoration? _getItemDecoration(Crew crew) {
    return crews.length > 1 && crew != crews.last
        ? const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.eerieBlack),
            ),
          )
        : null;
  }

  EdgeInsets _getItemPadding(Crew crew) {
    return crew == crews.first
        ? const EdgeInsets.only(bottom: 8)
        : const EdgeInsets.symmetric(vertical: 8);
  }
}
