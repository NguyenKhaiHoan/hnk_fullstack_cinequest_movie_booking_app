import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/blocs/location/location_bloc.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/app_bar_bottom_divider.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/common/widgets/padding_app_bar.dart';
import 'package:cinequest/src/common/widgets/svg_icon.dart';
import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/domain/movie/usecases/get_now_playing_movies_usecase.dart';
import 'package:cinequest/src/domain/movie/usecases/get_popular_movie_usecase.dart';
import 'package:cinequest/src/presentation/home/blocs/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:cinequest/src/presentation/home/blocs/popular_movie/popular_movie_bloc.dart';
import 'package:cinequest/src/presentation/home/widgets/carousel_now_playing_movie.dart';
import 'package:cinequest/src/presentation/home/widgets/carousel_popular_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '_mixins/home_page.mixin.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              NowPlayingMovieBloc(sl<GetNowPlayingMoviesUseCase>())
                ..add(
                  const NowPlayingMovieEvent.get(),
                ),
        ),
        BlocProvider(
          create: (context) => PopularMovieBloc(sl<GetPopularMoviesUseCase>())
            ..add(
              const PopularMovieEvent.get(),
            ),
        ),
      ],
      child: const _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  const _Page();

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> with _PageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gapH48,
            CarouselNowPlayingMovie(),
            gapH48,
            CarouselPopularMovie(),
          ],
        ),
      ),
    );
  }

  AppBarBottomDivider _buildAppBar(BuildContext context) {
    return AppBarBottomDivider(
      leadingWidth: 200,
      leading: PaddingAppBar(
        isLeft: true,
        alignment: Alignment.centerLeft,
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            return state.when(
              initial: () => _buildMessage('Initial'),
              loading: () => const CircularProgressIndicator(
                color: AppColors.white,
              ),
              failed: (failure) => _buildMessage(failure?.message ?? 'Error'),
              success: (location) =>
                  _buildLocationString(location?.split(', ')[2] ?? 'Viet Nam'),
            );
          },
        ),
      ),
      actions: [
        PaddingAppBar(
          isLeft: false,
          child: CustomCircleButton(
            iconPath: AppAssets.images.magnifyingGlass.path,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationString(String location) {
    return Row(
      children: [
        SvgIcon(iconPath: AppAssets.images.mapPin.path),
        gapW4,
        Text(location, style: context.textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildMessage(String message) {
    return SizedBox(
      child: Center(
        child: Text(message.hardcoded),
      ),
    );
  }
}
