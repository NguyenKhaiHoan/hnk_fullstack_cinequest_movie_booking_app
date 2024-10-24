import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/blocs/buttton/button_bloc.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/domain/movie/entities/movie.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_url.dart';
import 'package:cinequest/src/presentation/movie/widgets/favorite_button.dart';
import 'package:flutter/material.dart';

class NowPlayingMovieCarouselItem extends StatelessWidget {
  const NowPlayingMovieCarouselItem({
    required this.movie,
    required this.listener,
    required this.toggleFavorite,
    required this.isFavorite,
    required this.favoriteMovies,
    super.key,
  });

  final void Function(
    BuildContext context,
    ButtonState state,
  ) listener;

  final bool isFavorite;
  final List<Movie> favoriteMovies;

  final void Function(
    BuildContext context,
    List<Movie> favoriteMovies,
    Movie movie,
    bool isFavorite,
  ) toggleFavorite;

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        color: AppColors.eerieBlack,
        image: DecorationImage(
          image: NetworkImage(TMDBUrl.imageBaseUrl + movie.posterPath!),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(color: AppColors.eerieBlack.withOpacity(0.5)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CustomButton(
                    buttonType: ButtonType.elevated,
                    text: 'Tickets'.toUpperCase().hardcoded,
                    textColor: AppColors.black,
                  ),
                  const Spacer(),
                  FavoriteButton(
                    movie: movie,
                    favoriteMovies: favoriteMovies,
                    listener: listener,
                    toggleFavorite: toggleFavorite,
                    isFavorite: isFavorite,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
