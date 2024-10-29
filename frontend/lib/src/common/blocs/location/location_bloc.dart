import 'package:cinequest/src/common/service/location_stream_service.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/utils/location_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_bloc.freezed.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc({
    required LocationStreamService locationStreamService,
  })  : _locationStreamService = locationStreamService,
        super(const LocationState.initial()) {
    on<LocationEvent>((event, emit) async {
      await event.map(
        updated: (e) async => _onUpdated(e, emit),
      );
    });
  }

  final LocationStreamService _locationStreamService;

  Future<void> _onUpdated(
    _LocationUpdatedEvent e,
    Emitter<LocationState> emit,
  ) async {
    emit(const LocationState.loading());
    final latLng = _locationStreamService.currentLocation;
    try {
      if (latLng == null) {}
      final location = await LocationUtil.getAddressFromLatLng(latLng!);
      emit(LocationState.success(location: location.join(', ')));
    } on Failure catch (e) {
      emit(LocationState.failed(failure: e));
    }
  }
}
