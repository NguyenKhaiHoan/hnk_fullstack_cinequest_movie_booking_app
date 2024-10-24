import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/blocs/buttton/button_bloc.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/date_time_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/ui_util.dart';
import 'package:cinequest/src/domain/movie/entities/movie.dart';
import 'package:cinequest/src/presentation/movie/blocs/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:cinequest/src/presentation/movie/widgets/carousel_home_view.dart';
import 'package:cinequest/src/presentation/movie/widgets/carrousel_box.dart';
import 'package:cinequest/src/presentation/movie/widgets/now_playing_movie_carousel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '_mixins/carousel_now_playing_movie.mixin.dart';

class CarouselNowPlayingMovie extends StatefulWidget {
  const CarouselNowPlayingMovie({super.key});

  @override
  State<CarouselNowPlayingMovie> createState() =>
      _CarouselNowPlayingMovieState();
}

class _CarouselNowPlayingMovieState extends State<CarouselNowPlayingMovie>
    with CarouselNowPlayingMovieMixin {
  @override
  Widget build(BuildContext context) {
    final time = DateTime.now();
    return BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
      builder: (context, state) {
        return CarouselHomeView(
          subtitle: time.formatToMMMDD(),
          title: 'Premiers'.toUpperCase().hardcoded,
          titleStyle: context.textTheme.headlineMedium,
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
      height: 500,
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
      maxHeight: 500,
      children: List.generate(
        data.length,
        (index) => NowPlayingMovieCarouselItem(
          movie: data[index],
          favoriteMovies: data,
          listener: _listener,
          toggleFavorite: _toggleFavorite,
          isFavorite: false,
        ),
      ),
    );
  }

  Widget _buildFailureState(Failure failure) {
    return SizedBox(
      height: 500,
      width: UiUtil.deviceWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
        child: Text(
          failure.message,
          style:
              context.textTheme.bodySmall!.copyWith(color: AppColors.dimGray),
        ),
      ),
    );
  }
}
