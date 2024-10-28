import 'package:cinequest/src/common/constants/app_keys.dart';
import 'package:cinequest/src/common/service/location_stream_service.dart';
import 'package:cinequest/src/common/service/user_details_stream_service.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/routes/route_pages.dart';
import 'package:cinequest/src/domain/auth/usecases/get_user_details_usecase.dart';
import 'package:cinequest/src/domain/auth/usecases/get_user_usecase.dart';
import 'package:cinequest/src/external/services/location/location_service.dart';
import 'package:cinequest/src/external/services/storage/local/get_storage_service.dart';
import 'package:cinequest/src/external/services/storage/local/secure_storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'app_bloc.freezed.dart';
part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required GetStorageService getStorageService,
    required LocationService locationService,
    required LocationStreamService locationStreamService,
    required UserDetailsStreamService userDetailsStreamService,
    required GetUserUseCase getUserUseCase,
    required GetUserDetailsUseCase getUserDetailsUseCase,
    required SecureStorageService secureStorageService,
  })  : _getStorageService = getStorageService,
        _locationService = locationService,
        _locationStreamService = locationStreamService,
        _userDetailsStreamService = userDetailsStreamService,
        _getUserUseCase = getUserUseCase,
        _getUserDetailsUseCase = getUserDetailsUseCase,
        _secureStorageService = secureStorageService,
        super(const AppState.initial()) {
    on<AppEvent>((event, emit) async {
      await event.map(
        started: (e) async => _onStarted(e, emit),
      );
    });
  }

  final LocationService _locationService;
  final LocationStreamService _locationStreamService;
  final UserDetailsStreamService _userDetailsStreamService;
  final GetStorageService _getStorageService;
  final GetUserUseCase _getUserUseCase;
  final GetUserDetailsUseCase _getUserDetailsUseCase;
  final SecureStorageService _secureStorageService;

  Future<void> _onStarted(
    _AppStartedEvent event,
    Emitter<AppState> emit,
  ) async {
    final token = await _secureStorageService.getData(AppKeys.accessToken);
    // Xét nếu token là null tức app chưa được đăng nhập
    if (token != null) {
      // Nếu user khác null tức đã đăng nhập thì lấy data của user
      final user = await _getUserUseCase.call();

      await user.fold(
        (failure) async {
          // Lỗi do chưa đăng ký
          emit(AppState.unauthenticated(failure: failure));
        },
        (data) async {
          // Nếu có data user tức đã đăng ký rồi thì sẽ bắt đầu lấy thông tin
          // chi tiết của người dùng
          final userId = data.id;
          await GetStorageService.initializeStorage(userId);

          final userDetails = await _getUserDetailsUseCase.call(params: userId);

          await userDetails.fold((failure) {
            // Lỗi do tài khoản đăng ký chưa được setup
            emit(const AppState.accountNotSetup());
          }, (data) async {
            var latitude = _getStorageService.getData<double>(AppKeys.latitude);
            var longitude =
                _getStorageService.getData<double>(AppKeys.longitude);
            if (latitude == null && longitude == null) {
              final position = await _locationService.getGeoLocationPosition();
              latitude = position.latitude;
              longitude = position.longitude;
            }
            final newLocation = LatLng(latitude!, longitude!);
            _locationStreamService.updateLocation(newLocation);
            _userDetailsStreamService.updateUserDetails(data);
            emit(const AppState.authenticated());
          });
        },
      );
    } else {
      emit(const AppState.unauthenticated());
    }
    RouterPages.router.refresh();
  }
}
