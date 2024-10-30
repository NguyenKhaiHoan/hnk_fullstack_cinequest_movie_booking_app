import 'package:cinequest/src/common/constants/app_constant.dart';
import 'package:equatable/equatable.dart';

class MovieListParams extends Equatable {
  const MovieListParams({
    this.language = AppConstant.defaultLanguage,
    this.page = AppConstant.defaultPage,
    this.limit = AppConstant.defaultLimit,
  });

  final String language;
  final int page;
  final int limit;

  @override
  List<Object?> get props => [language, page, limit];

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'page': page,
      'limit': limit,
    };
  }
}
