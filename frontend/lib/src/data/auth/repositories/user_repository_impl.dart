import 'dart:convert';

import 'package:cinequest/src/common/entities/user_details.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/data/auth/datasources/user_remote_datasource.dart';
import 'package:cinequest/src/data/auth/repositories/_mappers/user_details_mapper.dart';
import 'package:cinequest/src/data/auth/repositories/_mappers/user_mapper.dart';
import 'package:cinequest/src/domain/auth/entities/user.dart';
import 'package:cinequest/src/domain/auth/repositories/user_repository.dart';
import 'package:cinequest/src/domain/auth/usecases/params/setup_account_params.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required UserRemoteDataSource userRemoteDataSource,
  }) : _userRemoteDataSource = userRemoteDataSource;

  final UserRemoteDataSource _userRemoteDataSource;

  final _userMapper = UserMapper();
  final _userDetailsMapper = UserDetailsMapper();

  @override
  FutureEither<User> getUser() async {
    try {
      final result = await _userRemoteDataSource.getUser();

      final response = _userMapper.toEntity(result);
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<UserDetails> getUserDetails(String params) async {
    try {
      final result = await _userRemoteDataSource.getUserDetails(params: params);

      final response = _userDetailsMapper.toEntity(result);
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<UserDetails> setupAccount(SetupAccountParams params) async {
    try {
      final result = await _userRemoteDataSource.setupAccount(
        file: params.file,
        userDetails: json.encode(params.userDetailsParams.toJson()),
      );

      final response = _userDetailsMapper.toEntity(result);
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
