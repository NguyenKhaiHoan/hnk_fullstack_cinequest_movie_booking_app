import 'package:equatable/equatable.dart';

class Role extends Equatable {
  const Role({
    required this.name,
    this.description,
  });

  final String name;
  final String? description;

  @override
  List<Object?> get props => [
        name,
        description,
      ];
}
