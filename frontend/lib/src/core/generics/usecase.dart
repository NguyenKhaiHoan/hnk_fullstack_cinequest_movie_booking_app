import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:equatable/equatable.dart';

/// Base chung cho các remote use case

abstract class FutureAsyncUseCase<Type, Params> {
  ///
  FutureEither<Type> call({Params params});
}

abstract class StreamSyncUseCase<Type, Params> {
  ///
  Stream<Type> call({Params params});
}

/// Thay thể cho việc không sử dụng tham số khi truyền vào use case
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
