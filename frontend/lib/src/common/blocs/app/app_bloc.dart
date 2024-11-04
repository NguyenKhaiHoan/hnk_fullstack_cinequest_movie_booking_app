import 'package:cinequest/src/common/constants/app_constant.dart';
import 'package:cinequest/src/common/entities/user_details.dart';
import 'package:cinequest/src/common/service/location_stream_service.dart';
import 'package:cinequest/src/common/service/user_details_stream_service.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/routes/route_pages.dart';
import 'package:cinequest/src/core/utils/location_util.dart';
import 'package:cinequest/src/domain/auth/entities/user.dart';
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
    final token = await _secureStorageService.getData(AppConstant.accessToken);

    if (token == null) {
      emit(const AppState.unauthenticated());
      RouterPages.router.refresh();
      return;
    }

    final user = await _fetchUser(emit);
    if (user == null) return;

    final userDetails = await _fetchUserDetails(user.id, emit);
    if (userDetails == null) return;

    final location = await _getOrFetchLocation(emit);
    if (await _isValidLocation(location, emit)) {
      _locationStreamService.updateLocation(location);
      _userDetailsStreamService.updateUserDetails(userDetails);
      emit(const AppState.authenticated());
    }

    RouterPages.router.refresh();
  }

  Future<User?> _fetchUser(Emitter<AppState> emit) async {
    final result = await _getUserUseCase.call();
    return result.fold(
      (failure) {
        emit(AppState.unauthenticated(failure: failure));
        return null;
      },
      (user) => user,
    );
  }

  Future<UserDetails?> _fetchUserDetails(
      String userId, Emitter<AppState> emit) async {
    await GetStorageService.initializeStorage(userId);
    final result = await _getUserDetailsUseCase.call(params: userId);
    return result.fold(
      (failure) {
        emit(const AppState.accountNotSetup());
        return null;
      },
      (data) => data,
    );
  }

  Future<LatLng> _getOrFetchLocation(Emitter<AppState> emit) async {
    emit(const AppState.findingLocation());
    var latitude = _getStorageService.getData<double>(AppConstant.latitude);
    var longitude = _getStorageService.getData<double>(AppConstant.longitude);

    if (latitude == null || longitude == null) {
      final position = await _locationService.getGeoLocationPosition();
      latitude = position.latitude;
      longitude = position.longitude;
      await _getStorageService.saveData(AppConstant.latitude, latitude);
      await _getStorageService.saveData(AppConstant.longitude, longitude);
    }

    return LatLng(latitude, longitude);
  }

  Future<bool> _isValidLocation(LatLng location, Emitter<AppState> emit) async {
    final locations = await LocationUtil.getAddressFromLatLng(location);
    if (!locations[2].contains('Hà Nội')) {
      emit(const AppState.invalidLocation());
      return false;
    }
    return true;
  }
}
