import 'package:cinequest/src/common/blocs/app/app_bloc.dart';
import 'package:cinequest/src/common/blocs/buttton/button_bloc.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/auth_app_bar.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mixins/setting_page.mixin.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with SettingPageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(title: 'Settings'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gapH48,
            Text(
              'Settings'.hardcoded,
              style: context.textTheme.headlineMedium,
            ),
            const Spacer(),
            BlocProvider(
              create: (context) => ButtonBloc(),
              child: BlocConsumer<ButtonBloc, ButtonState>(
                listener: _listener,
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      buttonType: ButtonType.outlined,
                      text: 'Log out'.toUpperCase().hardcoded,
                      isLoading: state == const ButtonState.loading(),
                      onPressed: () => _signOut(context),
                    ),
                  );
                },
              ),
            ),
            gapH8,
          ],
        ),
      ),
    );
  }
}
