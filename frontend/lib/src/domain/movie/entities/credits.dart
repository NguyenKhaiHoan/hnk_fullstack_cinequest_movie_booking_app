import 'package:cinequest/src/domain/movie/entities/cast.dart';
import 'package:cinequest/src/domain/movie/entities/crew.dart';
import 'package:equatable/equatable.dart';

class Credits extends Equatable {
  const Credits({
    required this.cast,
    required this.crew,
    this.id,
  });

  final int? id;
  final List<Cast> cast;
  final List<Crew> crew;

  @override
  List<Object?> get props => [id, cast, crew];
}
