import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/app_bar_bottom_divider.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/common/widgets/padding_app_bar.dart';
import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/core/extensions/date_time_extension.dart';
import 'package:cinequest/src/core/extensions/int_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/presentation/movie_detail/blocs/details_movie/details_movie_bloc.dart';
import 'package:cinequest/src/presentation/movie_detail/blocs/trailers_movie/trailers_movie_bloc.dart';
import 'package:cinequest/src/presentation/movie_detail/widgets/cast_crew_tab_view.dart';
import 'package:cinequest/src/presentation/movie_detail/widgets/movie_detail_content.dart';
import 'package:cinequest/src/presentation/movie_detail/widgets/movie_detail_image.dart';
import 'package:cinequest/src/presentation/movie_detail/widgets/movie_detail_trailer.dart';
import 'package:contentsize_tabbarview/contentsize_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '_mixins/movie_details_page.mixin.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({required this.movieId, super.key});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DetailsMovieBloc(sl())
            ..add(DetailsMovieEvent.get(movieId: movieId)),
        ),
        BlocProvider(
          create: (context) => TrailersMovieBloc(sl())
            ..add(
              TrailersMovieEvent.get(movieId: movieId),
            ),
        ),
      ],
      child: _Page(movieId: movieId),
    );
  }
}

class _Page extends StatefulWidget {
  const _Page({required this.movieId});

  final int movieId;

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page>
    with _PageMixin, TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsMovieBloc, DetailsMovieState>(
      builder: (context, state) {
        return state.when(
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: AppColors.white,
            ),
          ),
          success: (data) {
            final movieDetails = data;
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: _buildAppBar(context),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MovieDetailImage(backdropPath: movieDetails.backdropPath),
                    gapH16,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.defaultSpace),
                      child: Column(
                        children: [
                          MovieDetailContent(
                            releaseDate:
                                DateTime.parse(movieDetails.releaseDate)
                                    .formatToMMMDD(),
                            runtime: movieDetails.runtime.formatMinutes(),
                            originCountry:
                                movieDetails.originCountry.join(', '),
                            voteAverage: '★ ${movieDetails.voteAverage}',
                            title: movieDetails.title,
                            overview: movieDetails.overview,
                            genres: movieDetails.genres
                                .map((e) => e.name)
                                .join(', '),
                          ),
                        ],
                      ),
                    ),
                    gapH16,
                    const MovieDetailsTrailer(),
                    gapH16,
                    TabBar(
                      labelColor: AppColors.white,
                      unselectedLabelColor: AppColors.dimGray,
                      controller: _tabController,
                      indicatorColor: AppColors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: const EdgeInsets.all(10),
                      indicatorWeight: 1,
                      indicator: UnderlineTabIndicator(
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadiusMd,
                        ),
                      ),
                      tabs: [
                        Tab(
                          text: 'Sessions'.hardcoded.toUpperCase(),
                        ),
                        Tab(text: 'Cast & Grew'.hardcoded.toUpperCase()),
                        Tab(text: 'Ratings'.hardcoded.toUpperCase())
                      ],
                    ),
                    gapH32,
                    DefaultTabController(
                      length: 3,
                      child: ContentSizeTabBarView(
                        controller: _tabController,
                        children: [
                          const Center(child: Text('Tab 1 Content')),
                          CastCrewTabView(movieId: movieDetails.id),
                          const Center(child: Text('Tab 3 Content')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          failure: (failure) => _buildMessage(failure.message),
        );
      },
    );
  }

  Widget _buildMessage(String message) {
    return SizedBox(
      child: Center(
        child: Text(message.hardcoded),
      ),
    );
  }

  AppBarBottomDivider _buildAppBar(BuildContext context) {
    return AppBarBottomDivider(
      backgroundColor: Colors.transparent,
      hasBottom: false,
      leading: const SizedBox(),
      actions: [
        PaddingAppBar(
          isLeft: false,
          child: CustomCircleButton(
            iconPath: AppAssets.images.x.path,
            onPressed: () => context.pop(),
            backgroundColor: AppColors.black,
          ),
        ),
      ],
    );
  }
}
