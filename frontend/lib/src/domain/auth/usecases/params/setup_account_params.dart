import 'dart:io';

import 'package:cinequest/src/domain/auth/usecases/params/user_details_params.dart';
import 'package:equatable/equatable.dart';

class SetupAccountParams extends Equatable {
  const SetupAccountParams({
    required this.file,
    required this.userDetailsParams,
  });

  final File file;
  final UserDetailsParams userDetailsParams;

  @override
  List<Object?> get props => [
        file,
        userDetailsParams,
      ];

  Map<String, dynamic> toJson() {
    return {
      'file': file,
      'userDetailsParams': userDetailsParams.toJson(),
    };
  }
}
