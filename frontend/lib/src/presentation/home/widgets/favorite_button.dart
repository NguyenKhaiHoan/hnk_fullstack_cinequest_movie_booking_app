import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/blocs/buttton/button_bloc.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/domain/movie/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    required this.movie,
    required this.listener,
    required this.toggleFavorite,
    required this.isFavorite,
    required this.favoriteMovies,
    super.key,
  });

  final Movie movie;
  final bool isFavorite;
  final List<Movie> favoriteMovies;

  final void Function(
    BuildContext context,
    ButtonState state,
  ) listener;

  final void Function(
    BuildContext context,
    List<Movie> favoriteMovies,
    Movie movie,
    bool isFavorite,
  ) toggleFavorite;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ButtonBloc(),
      child: BlocBuilder<ButtonBloc, ButtonState>(
        builder: (context, state) {
          return CustomButton(
            buttonType: isFavorite ? ButtonType.elevated : ButtonType.outlined,
            colorFilter: isFavorite
                ? const ColorFilter.mode(AppColors.black, BlendMode.srcIn)
                : const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
            iconPath: isFavorite
                ? AppAssets.images.check.path
                : AppAssets.images.plus.path,
            onPressed: () =>
                toggleFavorite(context, favoriteMovies, movie, isFavorite),
          );
        },
      ),
    );
  }
}
