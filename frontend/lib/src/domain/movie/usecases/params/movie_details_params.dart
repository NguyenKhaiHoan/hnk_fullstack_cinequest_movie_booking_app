import 'package:cinequest/src/common/constants/app_constant.dart';
import 'package:equatable/equatable.dart';

class MovieDetailsParams extends Equatable {
  const MovieDetailsParams({
    required this.movieId,
    this.appendToResponse,
    this.includeImageLanguage,
    this.language = AppConstant.defaultLanguage,
    this.page = AppConstant.defaultPage,
  });

  final int movieId;
  final String? appendToResponse;
  final String? includeImageLanguage;
  final String language;
  final int page;

  @override
  List<Object?> get props => [movieId, language, page];
}
