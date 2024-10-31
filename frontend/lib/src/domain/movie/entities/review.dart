import 'package:cinequest/src/domain/movie/entities/author_detail.dart';
import 'package:equatable/equatable.dart';

class Review extends Equatable {
  const Review({
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.id,
    required this.updatedAt,
    required this.url,
  });

  final String author;
  final AuthorDetails authorDetails;
  final String content;
  final String createdAt;
  final String id;
  final String updatedAt;
  final String url;

  @override
  List<Object?> get props => [
        author,
        authorDetails,
        content,
        createdAt,
        id,
        updatedAt,
        url,
      ];
}
