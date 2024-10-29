import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/app_bar_bottom_divider.dart';
import 'package:cinequest/src/common/widgets/auth_app_bar.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/common/widgets/custom_divider.dart';
import 'package:cinequest/src/common/widgets/custom_text_field.dart';
import 'package:cinequest/src/common/widgets/padding_app_bar.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/presentation/location/blocs/select_location/select_location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '_mixins/search_movie_page.mixin.dart';

class SearchMoviePage extends StatelessWidget {
  const SearchMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _Page();
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
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildFilterMovieView(),
        _buildSearchMovieView(),
      ],
    );
  }

  AppBarBottomDivider _buildFilterMovieAppBar(BuildContext context) {
    return AppBarBottomDivider(
      hasBottom: false,
      leading: const SizedBox(),
      actions: [
        PaddingAppBar(
          isLeft: false,
          child: CustomCircleButton(
            iconPath: AppAssets.images.x.path,
            onPressed: () => context.pop(),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRating() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Rating'.hardcoded.toUpperCase(),
              style: context.textTheme.bodyMedium!
                  .copyWith(color: AppColors.dimGray),
            ),
            Text(
              '${_startRating.toInt()} - ${_endRating.toInt()}',
            ),
          ],
        ),
        gapH8,
        SliderTheme(
          data: const SliderThemeData(
            trackHeight: 0.3,
          ),
          child: RangeSlider(
            min: 1,
            max: 10,
            values: RangeValues(_startRating, _endRating),
            onChanged: _onChangedRating,
            activeColor: AppColors.white,
            inactiveColor: AppColors.eerieBlack,
            onChangeStart: _onChangeStartRating,
            onChangeEnd: _onChangeEndRating,
            divisions: 9,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterMovieView() {
    return Scaffold(
      appBar: _buildFilterMovieAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _next,
              child: AbsorbPointer(
                child: CustomTextField(
                  label: 'Search movie'.hardcoded,
                  controller: _searchTextEditingController,
                  onChanged: _searchCity,
                ),
              ),
            ),
            gapH48,
            Text(
              'Filter by'.hardcoded,
              style: context.textTheme.headlineMedium,
            ),
            gapH16,
            const CustomDivider(),
            gapH8,
            _buildFilterRating(),
            gapH8,
            const CustomDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchMovieView() {
    return Scaffold(
      appBar: AuthAppBar(
        title: 'Search'.toUpperCase(),
        onBackTap: _back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
        child: Column(
          children: [
            CustomTextField(
              label: 'Search movie'.hardcoded,
              controller: _searchTextEditingController,
              onChanged: _searchCity,
            ),
          ],
        ),
      ),
    );
  }
}
