import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/app_bar_bottom_divider.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/common/widgets/padding_app_bar.dart';
import 'package:cinequest/src/common/widgets/svg_icon.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

part '_mixins/home_page.mixin.dart';

/// Trang Home
class HomePage extends StatelessWidget {
  /// Constructor
  const HomePage({super.key});

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
      appBar: _buildAppBar(context),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }

  AppBarBottomDivider _buildAppBar(BuildContext context) {
    return AppBarBottomDivider(
      leadingWidth: 110,
      leading: PaddingAppBar(
        isLeft: true,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            SvgIcon(iconPath: AppAssets.images.mapPin.path),
            gapW4,
            Text('Taskent', style: context.textTheme.bodyMedium),
          ],
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
}
