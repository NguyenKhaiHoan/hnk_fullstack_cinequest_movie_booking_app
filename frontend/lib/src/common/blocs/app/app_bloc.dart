import 'package:cinequest/src/common/constants/app_keys.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/routes/route_pages.dart';
import 'package:cinequest/src/domain/auth/entities/user_details.dart';
import 'package:cinequest/src/domain/auth/usecases/get_user_details_usecase.dart';
import 'package:cinequest/src/domain/auth/usecases/get_user_usecase.dart';
import 'package:cinequest/src/external/services/storage/local/secure_storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_bloc.freezed.dart';
part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required GetUserUseCase getUserUseCase,
    required GetUserDetailsUseCase getUserDetailsUseCase,
    required SecureStorageService secureStorageService,
  })  : _getUserUseCase = getUserUseCase,
        _getUserDetailsUseCase = getUserDetailsUseCase,
        _secureStorageService = secureStorageService,
        super(const AppState.initial()) {
    on<AppEvent>((event, emit) async {
      await event.map(
        started: (e) async => _onStarted(e, emit),
      );
    });
  }

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
          final userDetails =
              await _getUserDetailsUseCase.call(params: data.id);

          userDetails.fold((failure) {
            // Lỗi do tài khoản đăng ký chưa được setup
            emit(const AppState.accountNotSetup());
          }, (data) {
            emit(AppState.authenticated(userDetails: data));
          });
        },
      );
    } else {
      emit(const AppState.unauthenticated());
    }
    RouterPages.router.refresh();
  }
}
