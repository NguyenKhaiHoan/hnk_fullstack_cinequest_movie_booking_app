import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/app_bar_bottom_divider.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/common/widgets/custom_text_field.dart';
import 'package:cinequest/src/common/widgets/padding_app_bar.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/domain/location/entities/city.dart';
import 'package:cinequest/src/presentation/location/blocs/select_location/select_location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '_mixins/select_location_page.mixin.dart';

class SelectLocationPage extends StatelessWidget {
  const SelectLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchLocationBloc()..add(const SearchLocationEvent.loaded()),
      child: const _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  const _Page({super.key});

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> with _PageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
        child: Column(
          children: [
            CustomTextField(
              label: 'Name of city'.hardcoded,
              controller: _searchTextEditingController,
              onChanged: _searchCity,
            ),
            gapH24,
            Expanded(
              child: BlocBuilder<SearchLocationBloc, SearchLocationState>(
                builder: (context, state) {
                  return state.when(
                    loading: _buildLoadingState,
                    success: _buildSuccessState,
                    failure: _buildFailureState,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBarBottomDivider _buildAppBar(BuildContext context) {
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

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.white,
      ),
    );
  }

  Widget _buildSuccessState(List<City>? data) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: data?.length ?? 0,
      itemBuilder: (BuildContext context, int index) =>
          Text(data?[index].name ?? ''),
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget _buildFailureState(Failure? failure) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
      child: Text(
        failure?.message ?? 'Error',
        style: context.textTheme.bodySmall!.copyWith(color: AppColors.dimGray),
      ),
    );
  }
}
