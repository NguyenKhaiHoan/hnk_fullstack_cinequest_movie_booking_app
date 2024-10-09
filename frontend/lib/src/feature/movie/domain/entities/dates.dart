import 'package:equatable/equatable.dart';

/// Dates entity
class Dates extends Equatable {
  /// Constructor
  const Dates({
    this.maximum,
    this.minimum,
  });

  final DateTime? maximum;

  final DateTime? minimum;

  @override
  List<Object?> get props => [maximum, minimum];
}
