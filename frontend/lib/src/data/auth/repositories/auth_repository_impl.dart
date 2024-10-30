import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/routes/route_pages.dart';
import 'package:cinequest/src/data/auth/datasources/auth_remote_datasource.dart';
import 'package:cinequest/src/data/auth/repositories/_mappers/token_mapper.dart';
import 'package:cinequest/src/domain/auth/entities/token.dart';
import 'package:cinequest/src/domain/auth/repositories/auth_repository.dart';
import 'package:cinequest/src/domain/auth/usecases/params/email_params.dart';
import 'package:cinequest/src/domain/auth/usecases/params/login_params.dart';
import 'package:cinequest/src/domain/auth/usecases/params/sign_up_params.dart';
import 'package:cinequest/src/domain/auth/usecases/params/verify_user_params.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
  }) : _authRemoteDataSource = authRemoteDataSource;

  final AuthRemoteDataSource _authRemoteDataSource;

  final TokenMapper _tokenMapper = TokenMapper();

  @override
  FutureEither<void> logOut() async {
    try {
      final result = await _authRemoteDataSource.logOut();

      // Đặt lại path bằng rỗng để tránh bị xét lại rằng đã có
      // path của welcome page, home page do đã được thêm vào từ trước
      RouterPages.refreshPath();

      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<Token> login(LoginParams params) async {
    try {
      final result = await _authRemoteDataSource.login(params);
      final response = _tokenMapper.toEntity(result);

      // Làm mới lại toàn bộ tuyến được được lưu lại trong app
      RouterPages.refreshPath();

      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> signUp(SignUpParams params) async {
    try {
      await _authRemoteDataSource.signUp(params);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<Token> verifyUser(VerifyUserParams params) async {
    try {
      final result = await _authRemoteDataSource.verifyUser(params);
      final response = _tokenMapper.toEntity(result);

      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> forgotPassword(EmailParams params) async {
    try {
      await _authRemoteDataSource.forgotPassword(params);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> resendCode(EmailParams params) async {
    try {
      await _authRemoteDataSource.resendCode(params);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
