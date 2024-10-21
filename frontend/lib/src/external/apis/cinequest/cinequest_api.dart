import 'package:cinequest/src/core/network/model/response.dart';
import 'package:cinequest/src/data/auth/models/requests/login_request.dart';
import 'package:cinequest/src/data/auth/models/requests/sign_up_request.dart';
import 'package:cinequest/src/data/auth/models/requests/verify_user_request.dart';
import 'package:cinequest/src/data/auth/models/responses/token_response.dart';
import 'package:cinequest/src/data/auth/models/user_details_model.dart';
import 'package:cinequest/src/data/auth/models/user_model.dart';
import 'package:cinequest/src/data/movie/models/requests/movie_request.dart';
import 'package:cinequest/src/data/movie/models/responses/movie_list_response.dart';
import 'package:cinequest/src/external/apis/cinequest/cinequest_url.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'cinequest_api.g.dart';

@RestApi(baseUrl: CineQuestUrl.baseUrl)
abstract class CineQuestApi {
  factory CineQuestApi(Dio dio) = _CineQuestApi;

  @POST(CineQuestUrl.loginUrl)
  Future<TokenResponse> login({
    @Body() required LoginRequest request,
  });

  @POST(CineQuestUrl.signUpUrl)
  Future<void> signUp({
    @Body() required SignUpRequest request,
  });

  @POST(CineQuestUrl.verifyUrl)
  Future<TokenResponse> verify({
    @Body() required VerifyUserRequest request,
  });

  @GET(CineQuestUrl.getUserUrl)
  Future<UserModel> getUser();

  @POST(CineQuestUrl.getUserDetailsUrl)
  Future<UserDetailsModel> getUserDetails({
    @Path('user_id') required String userId,
  });

  @GET(CineQuestUrl.getFavoritesUrl)
  Future<MovieListResponse> getFavorites({
    @Query('language') required String language,
    @Query('page') required int page,
    @Query('limit') required int limit,
  });

  @POST(CineQuestUrl.addFavoriteUrl)
  Future<ApiResponse> addFavorite({
    @Path('user_id') required String userId,
    @Body() required MovieRequest request,
  });

  @POST(CineQuestUrl.deleteFavoriteUrl)
  Future<ApiResponse> deleteFavorite({
    @Path('user_id') required String userId,
    @Path('movie_id') required int movieId,
  });
}
