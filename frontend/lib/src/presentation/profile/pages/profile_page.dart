import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/app_bar_bottom_divider.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/common/widgets/padding_app_bar.dart';
import 'package:cinequest/src/core/routes/route_enums.dart';
import 'package:cinequest/src/presentation/profile/widgets/profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part '_mixins/profile_page.mixin.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
    return Scaffold(
      appBar: AppBarBottomDivider(
        leadingWidth: 110,
        leading: PaddingAppBar(
          isLeft: true,
          alignment: Alignment.centerLeft,
          child: CustomCircleButton(
            iconPath: AppAssets.images.gear.path,
            onPressed: _moveToSettingPage,
          ),
        ),
        actions: [
          CustomCircleButton(iconPath: AppAssets.images.magnifyingGlass.path),
          gapW8,
          PaddingAppBar(
            isLeft: false,
            child: CustomCircleButton(iconPath: AppAssets.images.bell.path),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
        child: Column(
          children: [
            gapH48,
            ProfilePhoto(),
          ],
        ),
      ),
    );
  }
}
