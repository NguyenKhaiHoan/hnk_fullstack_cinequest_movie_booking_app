import 'package:equatable/equatable.dart';

class EmailParams extends Equatable {
  const EmailParams({
    required this.email,
  });

  final String email;

  @override
  List<Object?> get props => [
        email,
      ];
}
