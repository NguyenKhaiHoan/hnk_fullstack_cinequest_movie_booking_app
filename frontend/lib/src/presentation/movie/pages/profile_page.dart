import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/app_bar_bottom_divider.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/common/widgets/padding_app_bar.dart';
import 'package:cinequest/src/core/routes/route_enums.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part '_mixins/profile_page.mixin.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with ProfilePageMixin {
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
        child: Column(),
      ),
    );
  }
}
