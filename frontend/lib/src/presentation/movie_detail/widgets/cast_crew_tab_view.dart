import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_url.dart';
import 'package:cinequest/src/presentation/movie_detail/blocs/credits_movie/credits_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CastCrewTabView extends StatelessWidget {
  const CastCrewTabView({required this.movieId, super.key});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreditsMovieBloc(sl())
        ..add(
          CreditsMovieEvent.get(movieId: movieId),
        ),
      child: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({super.key});

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
          success: (data) {
            return SizedBox(
              height: 200,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.defaultSpace,
                ),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final cast = data.cast[index];
                  return index == 4
                      ? Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.eerieBlack,
                              ),
                              child: Center(
                                child: Text(
                                  '+${data.cast.length - 5}',
                                  style: context.textTheme.headlineSmall,
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          width: 120,
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      TMDBUrl.imageBaseUrl + cast.profilePath!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              gapH8,
                              Text(
                                cast.originalName ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              gapH8,
                              Text(
                                cast.character ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.bodyMedium!
                                    .copyWith(color: AppColors.dimGray),
                              ),
                            ],
                          ),
                        );
                },
                separatorBuilder: (context, index) => gapW16,
                itemCount: data.cast.length > 5 ? 5 : data.cast.length,
              ),
            );
          },
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
