import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/routes/route_pages.dart';
import 'package:cinequest/src/data/auth/datasources/_mapper/token_mapper.dart';
import 'package:cinequest/src/data/auth/datasources/auth_remote_datasource.dart';
import 'package:cinequest/src/data/auth/models/requests/email_request.dart';
import 'package:cinequest/src/data/auth/models/requests/login_request.dart';
import 'package:cinequest/src/data/auth/models/requests/sign_up_request.dart';
import 'package:cinequest/src/data/auth/models/requests/verify_user_request.dart';
import 'package:cinequest/src/domain/auth/entities/token.dart';
import 'package:cinequest/src/domain/auth/repositories/auth_repository.dart';
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
  FutureEither<Token> login(LoginRequest request) async {
    try {
      final result = await _authRemoteDataSource.login(request);
      final response = _tokenMapper.toEntity(result);

      // Làm mới lại toàn bộ tuyến được được lưu lại trong app
      RouterPages.refreshPath();

      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> signUp(SignUpRequest request) async {
    try {
      await _authRemoteDataSource.signUp(request);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<Token> verifyUser(VerifyUserRequest request) async {
    try {
      final result = await _authRemoteDataSource.verifyUser(request);
      final response = _tokenMapper.toEntity(result);

      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> forgotPassword(EmailRequest request) async {
    try {
      await _authRemoteDataSource.forgotPassword(request);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> resendCode(EmailRequest request) async {
    try {
      await _authRemoteDataSource.resendCode(request);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
