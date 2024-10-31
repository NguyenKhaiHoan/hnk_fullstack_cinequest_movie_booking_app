import 'dart:io';

import 'package:cinequest/src/core/network/model/response.dart';
import 'package:cinequest/src/data/auth/models/responses/token_response.dart';
import 'package:cinequest/src/data/auth/models/user_details_model.dart';
import 'package:cinequest/src/data/auth/models/user_model.dart';
import 'package:cinequest/src/data/movie/models/movie_model.dart';
import 'package:cinequest/src/data/movie/models/responses/list_response.dart';
import 'package:cinequest/src/domain/auth/usecases/params/email_params.dart';
import 'package:cinequest/src/domain/auth/usecases/params/login_params.dart';
import 'package:cinequest/src/domain/auth/usecases/params/sign_up_params.dart';
import 'package:cinequest/src/domain/auth/usecases/params/verify_user_params.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_params.dart';
import 'package:cinequest/src/external/apis/cinequest/cinequest_url.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'cinequest_api.g.dart';

@RestApi(baseUrl: CineQuestUrl.baseUrl)
abstract class CineQuestApi {
  factory CineQuestApi(Dio dio) = _CineQuestApi;

  @POST(CineQuestUrl.loginUrl)
  Future<TokenResponse> login({
    @Body() required LoginParams params,
  });

  @POST(CineQuestUrl.signUpUrl)
  Future<void> signUp({
    @Body() required SignUpParams params,
  });

  @POST(CineQuestUrl.verifyUrl)
  Future<TokenResponse> verify({
    @Body() required VerifyUserParams params,
  });

  @POST(CineQuestUrl.resendCodeUrl)
  Future<void> resendCode({
    @Body() required EmailParams params,
  });

  @GET(CineQuestUrl.getUserUrl)
  Future<UserModel> getUser();

  @GET(CineQuestUrl.getUserDetailsUrl)
  Future<UserDetailsModel> getUserDetails({
    @Path('user_id') required String userId,
  });

  @POST(CineQuestUrl.forgotPasswordUrl)
  Future<void> forgotPassword({
    @Body() required EmailParams params,
  });

  @POST(CineQuestUrl.setupAccountUrl)
  Future<UserDetailsModel> setupAccount({
    @Part(name: 'profile_photo') required File file,
    @Part(name: 'user_details') required String userDetails,
  });

  @GET(CineQuestUrl.getFavoritesUrl)
  Future<ListResponse<MovieModel>> getFavorites({
    @Query('language') required String language,
    @Query('page') required int page,
    @Query('limit') required int limit,
  });

  @POST(CineQuestUrl.addFavoriteUrl)
  Future<ApiResponse> addFavorite({
    @Path('user_id') required String userId,
    @Body() required MovieParams params,
  });

  @POST(CineQuestUrl.deleteFavoriteUrl)
  Future<ApiResponse> deleteFavorite({
    @Path('user_id') required String userId,
    @Path('movie_id') required int movieId,
  });
}
