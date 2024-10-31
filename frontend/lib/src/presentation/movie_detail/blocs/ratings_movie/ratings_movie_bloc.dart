import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/domain/movie/entities/review.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ratings_movie_bloc.freezed.dart';
part 'ratings_movie_event.dart';
part 'ratings_movie_state.dart';

class RatingsMovieBloc extends Bloc<RatingsMovieEvent, RatingsMovieState> {
  RatingsMovieBloc() : super(const RatingsMovieState.loading()) {
    on<RatingsMovieEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
