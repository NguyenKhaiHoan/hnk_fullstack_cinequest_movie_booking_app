import 'package:cinequest/src/feature/movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

/// Params của use case AddFavoriteUseCase
class AddFavoriteParams extends Equatable {
  /// Constructor
  const AddFavoriteParams({
    required this.movie,
    required this.favorite,
  });

  final Movie movie;
  final bool favorite;

  @override
  List<Object?> get props => [movie, favorite];
}
