import 'package:cinequest/src/core/network/model/response.dart';
import 'package:cinequest/src/external/apis/cinequest/cinequest_url.dart';
import 'package:cinequest/src/feature/movie/data/models/requests/add_favorite_request.dart';
import 'package:cinequest/src/feature/movie/data/models/responses/movie_list_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'cinequest_api.g.dart';

/// Api TheMovieDb
@RestApi(baseUrl: CineQuestUrl.baseUrl)
abstract class CineQuestApi {
  factory CineQuestApi(Dio dio) = _CineQuestApi;

  /// Lấy dữ liệu danh sách phim yêu thích
  @GET(CineQuestUrl.getFavoritesUrl)
  Future<MovieListResponse> getFavorites({
    @Query('language') required String language,
    @Query('page') required int page,
  });

  /// Thêm vào danh sách yêu thích
  @POST(CineQuestUrl.addFavoriteUrl)
  Future<ApiResponse> addFavorite({
    @Body() required AddFavoriteRequest request,
  });

  /// Đăng nhập
  @POST(CineQuestUrl.loginUrl)
  Future<ApiResponse> login({
    @Body() required AddFavoriteRequest request,
  });

  /// Đăng ký
  @POST(CineQuestUrl.signUpUrl)
  Future<ApiResponse> signUp({
    @Body() required AddFavoriteRequest request,
  });

  /// Xác thực
  @POST(CineQuestUrl.verifyUrl)
  Future<ApiResponse> verify({
    @Body() required AddFavoriteRequest request,
  });

  /// Gửi lại code xác thực
  @POST(CineQuestUrl.resendCodeUrl)
  Future<ApiResponse> resendCodeUrl({
    @Body() required AddFavoriteRequest request,
  });

  /// Làm mới lại các mã token
  @POST(CineQuestUrl.refreshTokenUrl)
  Future<ApiResponse> refreshToken({
    @Body() required AddFavoriteRequest request,
  });

  /// Quên mật khẩu
  @POST(CineQuestUrl.forgotPasswordUrl)
  Future<ApiResponse> forgotPasswordUrl({
    @Body() required AddFavoriteRequest request,
  });
}
