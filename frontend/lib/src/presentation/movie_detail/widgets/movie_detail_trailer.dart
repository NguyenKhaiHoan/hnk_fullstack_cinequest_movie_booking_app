import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/presentation/movie_detail/blocs/trailers_movie/trailers_movie_bloc.dart';
import 'package:cinequest/src/presentation/movie_detail/widgets/movie_trailer_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailsTrailer extends StatelessWidget {
  const MovieDetailsTrailer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrailersMovieBloc, TrailersMovieState>(
      builder: (context, state) {
        return state.when(
          loading: () => const SizedBox(
            height: 250,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.white,
              ),
            ),
          ),
          success: (data) => SizedBox(
            height: 250,
            child: ListView.separated(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => AbsorbPointer(
                child: MovieTrailerThumbnail(
                  video: data[index],
                ),
              ),
              separatorBuilder: (context, index) => gapW8,
              itemCount: data.length > 2 ? 2 : data.length,
            ),
          ),
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
