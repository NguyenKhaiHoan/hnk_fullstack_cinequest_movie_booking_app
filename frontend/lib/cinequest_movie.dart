import 'package:cinequest/src/common/blocs/app/app_bloc.dart';
import 'package:cinequest/src/common/blocs/connectivity/connectivity_bloc.dart';
import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/core/routes/route_pages.dart';
import 'package:cinequest/src/core/themes/app_themes.dart';
import 'package:cinequest/src/core/utils/toast_util.dart';
import 'package:cinequest/src/core/utils/ui_util.dart';
import 'package:cinequest/src/presentation/location/presentation/pages/finding_location_page.dart';
import 'package:cinequest/src/presentation/location/presentation/pages/invalid_location_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

part 'cinequest_movie.mixin.dart';

class CineQuestMovie extends StatefulWidget {
  const CineQuestMovie({super.key});

  @override
  State<CineQuestMovie> createState() => _CineQuestMovieState();
}

class _CineQuestMovieState extends State<CineQuestMovie>
    with CineQuestMovieMixin {
  final router = RouterPages.router;

  @override
  Widget build(BuildContext context) {
    UiUtil.initialize(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConnectivityBloc(connectivityService: sl()),
        ),
        BlocProvider(
          create: (context) => AppBloc(
            getStorageService: sl(),
            locationService: sl(),
            locationStreamService: sl(),
            userDetailsStreamService: sl(),
            getUserUseCase: sl(),
            getUserDetailsUseCase: sl(),
            secureStorageService: sl(),
          )..add(const AppEvent.started()),
        ),
      ],
      child: ToastificationWrapper(
        child: MaterialApp.router(
          theme: AppThemes.darkTheme,
          routeInformationProvider: router.routeInformationProvider,
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          builder: (context, child) {
            return Scaffold(
              body: MultiBlocListener(
                listeners: [
                  BlocListener<ConnectivityBloc, ConnectivityState>(
                    listener: _listenerConnectivity,
                  ),
                  BlocListener<AppBloc, AppState>(
                    listener: _listenerApp,
                  ),
                ],
                child: BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      findingLocation: () => const FindingLocationPage(),
                      invalidLocation: () => const InvalidLocationPage(),
                      orElse: () => child!,
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
