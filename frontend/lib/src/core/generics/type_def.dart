import 'package:cinequest/src/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

/// Sử dụng typedef để rút gọn Future<Either<Failure, Type>>
typedef FutureEither<Type> = Future<Either<Failure, Type>>;

/// Sử dụng typedef để rút gọn Stream<Either<Failure, Type>>
typedef StreamEither<Type> = Stream<Either<Failure, Type>>;
