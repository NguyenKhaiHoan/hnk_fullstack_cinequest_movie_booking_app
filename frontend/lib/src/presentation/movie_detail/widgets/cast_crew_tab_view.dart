import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/common/widgets/custom_divider.dart';
import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/domain/movie/entities/cast.dart';
import 'package:cinequest/src/domain/movie/entities/crew.dart';
import 'package:cinequest/src/presentation/movie_detail/blocs/credits_movie/credits_movie_bloc.dart';
import 'package:cinequest/src/presentation/movie_detail/widgets/cast_item.dart';
import 'package:cinequest/src/presentation/movie_detail/widgets/crew_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CastCrewTabView extends StatelessWidget {
  const CastCrewTabView({required this.movieId, super.key});
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CreditsMovieBloc(sl())..add(CreditsMovieEvent.get(movieId: movieId)),
      child: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditsMovieBloc, CreditsMovieState>(
      builder: (context, state) {
        return state.when(
          loading: () => const SizedBox(
            height: 300,
            child: CircularProgressIndicator(
              color: AppColors.white,
            ),
          ),
          success: (data) =>
              CastCrewContent(casts: data.cast, crews: data.crew),
          failure: (failure) => _buildMessage(failure.message),
        );
      },
    );
  }

  Widget _buildMessage(String message) {
    return SizedBox(
      child: Center(
        child: Text(message),
      ),
    );
  }
}

class CastCrewContent extends StatelessWidget {
  const CastCrewContent({required this.casts, required this.crews, super.key});
  final List<Cast> casts;
  final List<Crew> crews;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CastCrewList(casts: casts),
        gapH16,
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
          child: Column(
            children: [
              const CustomDivider(),
              gapH8,
              CrewDetails(crews: crews),
              gapH8,
              const SeeFullListButton(),
            ],
          ),
        )
      ],
    );
  }
}

class CastCrewList extends StatelessWidget {
  const CastCrewList({required this.casts, super.key});
  final List<Cast> casts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
        scrollDirection: Axis.horizontal,
        itemCount: casts.length > 5 ? 5 : casts.length,
        itemBuilder: (context, index) {
          if (index == 4) {
            return Container(
              margin: const EdgeInsets.only(left: 16),
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.eerieBlack,
              ),
              child: Center(
                child: Text(
                  '+${casts.length - 5}',
                  style: context.textTheme.headlineSmall,
                ),
              ),
            );
          } else {
            final cast = casts[index];
            return CastItem(
              profilePath: cast.profilePath ?? '',
              originalName: cast.originalName ?? '',
              character: cast.character ?? '',
              hasLeftSpace: index != 0,
            );
          }
        },
      ),
    );
  }
}

class CrewDetails extends StatelessWidget {
  const CrewDetails({required this.crews, super.key});
  final List<Crew> crews;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Grew'.hardcoded.toUpperCase(),
          style:
              context.textTheme.bodyMedium!.copyWith(color: AppColors.dimGray),
        ),
        gapW62,
        Expanded(
          child: Column(
            children: [
              _buildCrewRow(
                'Director',
                crews.where((crew) => crew.job == 'Director').toList(),
                context,
              ),
              const CustomDivider(),
              _buildCrewRow(
                'Producers',
                crews.where((crew) => crew.job == 'Producer').toList(),
                context,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCrewRow(
    String title,
    List<Crew> crews,
    BuildContext context,
  ) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: _buildTitle(context, title),
            ),
            Expanded(
              flex: 3,
              child: _buildCrewList(context, crews),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Text(
      title.hardcoded,
      style: context.textTheme.bodyMedium!.copyWith(color: AppColors.dimGray),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _buildCrewList(BuildContext context, List<Crew> crews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          crews.map((crew) => CrewItem(crew: crew, crews: crews)).toList(),
    );
  }
}

class SeeFullListButton extends StatelessWidget {
  const SeeFullListButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      width: double.infinity,
      buttonType: ButtonType.outlined,
      text: 'See full list'.hardcoded,
    );
  }
}
