import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/app_bar_bottom_divider.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/common/widgets/padding_app_bar.dart';
import 'package:cinequest/src/common/widgets/tickets_button.dart';
import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/date_time_extension.dart';
import 'package:cinequest/src/core/extensions/int_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/ui_util.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_url.dart';
import 'package:cinequest/src/presentation/movie_detail/blocs/details_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({required this.movieId, super.key});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailsMovieBloc(sl())..add(DetailsMovieEvent.get(movieId: movieId)),
      child: _Page(movieId: movieId),
    );
  }
}

class _Page extends StatefulWidget {
  const _Page({required this.movieId});

  final int movieId;

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsMovieBloc, DetailsMovieState>(
      builder: (context, state) {
        return state.when(
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: AppColors.white,
            ),
          ),
          success: (data) {
            final movieDetails = data;
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: _buildAppBar(context),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: UiUtil.deviceHeight * 2 / 3,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppSizes.borderRadiusXl),
                            color: AppColors.eerieBlack,
                            image: DecorationImage(
                              image: NetworkImage(
                                TMDBUrl.imageBaseUrl +
                                    movieDetails.backdropPath,
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppSizes.defaultSpace),
                      child: Column(
                        children: [
                          Text(
                            '${DateTime.parse(movieDetails.releaseDate).formatToMMMDD()}   ·   ${movieDetails.runtime.formatMinutes()}   ·   ${movieDetails.originCountry.join(', ')}   ·   ★ ${movieDetails.voteAverage}'
                                .toUpperCase(),
                            style: context.textTheme.bodySmall!
                                .copyWith(color: AppColors.dimGray),
                          ),
                          gapH32,
                          Text(
                            movieDetails.title,
                            style: context.textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                          gapH32,
                          Text(
                            movieDetails.overview,
                            textAlign: TextAlign.center,
                          ),
                          gapH32,
                          Text(
                            movieDetails.genres
                                .map((e) => e.name)
                                .join(', ')
                                .toUpperCase(),
                            style: context.textTheme.bodySmall!
                                .copyWith(color: AppColors.dimGray),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
        child: Text(message.hardcoded),
      ),
    );
  }

  AppBarBottomDivider _buildAppBar(BuildContext context) {
    return AppBarBottomDivider(
      backgroundColor: Colors.transparent,
      hasBottom: false,
      leading: const SizedBox(),
      actions: [
        PaddingAppBar(
          isLeft: false,
          child: CustomCircleButton(
            iconPath: AppAssets.images.x.path,
            onPressed: () => context.pop(),
            backgroundColor: AppColors.black,
          ),
        ),
      ],
    );
  }
}
