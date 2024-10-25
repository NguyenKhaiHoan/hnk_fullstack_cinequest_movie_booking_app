import 'package:equatable/equatable.dart';

class MovieListParams extends Equatable {
  const MovieListParams({
    this.language = 'en-US',
    this.page = 1,
    this.limit = 20,
  });

  final String language;
  final int page;
  final int limit;

  @override
  List<Object?> get props => [language, page, limit];
}
