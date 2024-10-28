import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/ui_util.dart';
import 'package:cinequest/src/domain/movie/entities/movie.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_url.dart';
import 'package:cinequest/src/presentation/home/blocs/popular_movie/popular_movie_bloc.dart';
import 'package:cinequest/src/presentation/home/widgets/carousel_home_view.dart';
import 'package:cinequest/src/presentation/home/widgets/carrousel_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselPopularMovie extends StatelessWidget {
  const CarouselPopularMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularMovieBloc, PopularMovieState>(
      builder: (context, state) {
        return CarouselHomeView(
          title: 'Popular now'.hardcoded,
          titleStyle: context.textTheme.bodyLarge,
          child: state.when(
            loading: _buildLoadingState,
            success: _buildSuccessState,
            failure: _buildFailureState,
          ),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return SizedBox(
      height: 250,
      width: UiUtil.deviceWidth,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget _buildSuccessState(List<Movie> data) {
    return CarouselBox(
      maxHeight: 250,
      children: List.generate(
        data.length,
        (index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
              color: AppColors.eerieBlack,
              image: DecorationImage(
                image: NetworkImage(
                  TMDBUrl.imageBaseUrl + data[index].posterPath!,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  color: AppColors.eerieBlack.withOpacity(0.5),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Builder(
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          data[index]
                              .voteAverage
                              .toString()
                              .toUpperCase()
                              .hardcoded,
                          style: context.textTheme.bodySmall,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFailureState(Failure failure) {
    return SizedBox(
      height: 250,
      width: UiUtil.deviceWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
        child: Builder(
          builder: (context) {
            return Text(
              failure.message,
              style: context.textTheme.bodySmall!
                  .copyWith(color: AppColors.dimGray),
            );
          },
        ),
      ),
    );
  }
}
