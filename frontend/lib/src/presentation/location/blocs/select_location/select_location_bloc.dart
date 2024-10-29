import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/domain/location/entities/city.dart';
import 'package:cinequest/src/domain/location/usecases/get_cities_usecase.dart';
import 'package:cinequest/src/domain/location/usecases/search_city_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_location_bloc.freezed.dart';
part 'select_location_event.dart';
part 'select_location_state.dart';

class SearchLocationBloc
    extends Bloc<SearchLocationEvent, SearchLocationState> {
  SearchLocationBloc() : super(const SearchLocationState.loading()) {
    on<SearchLocationEvent>((event, emit) async {
      await event.map(
        searched: (e) async => _onSearched(e, emit),
        loaded: (e) async => _onLoaded(e, emit),
      );
    });
  }

  Future<void> _onSearched(
    _SearchLocationSearchedEvent e,
    Emitter<SearchLocationState> emit,
  ) async {
    emit(const SearchLocationState.loading());
    final result = await sl<SearchCityUseCase>().call(params: e.cityName);
    result.fold(
      (failure) => emit(SearchLocationState.failure(failure: failure)),
      (data) => emit(SearchLocationState.success(data: data)),
    );
  }

  Future<void> _onLoaded(
    _SearchLocationLoadedEvent e,
    Emitter<SearchLocationState> emit,
  ) async {
    emit(const SearchLocationState.loading());
    final result = await sl<GetCitiesUseCase>().call();
    result.fold(
      (failure) => emit(SearchLocationState.failure(failure: failure)),
      (data) => emit(SearchLocationState.success(data: data)),
    );
  }
}
