import 'dart:io';

import 'package:cinequest/src/common/blocs/app/app_bloc.dart';
import 'package:cinequest/src/common/blocs/buttton/button_bloc.dart';
import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/bottom_sheet_util.dart';
import 'package:cinequest/src/core/utils/toast_util.dart';
import 'package:cinequest/src/domain/auth/usecases/params/setup_account_params.dart';
import 'package:cinequest/src/domain/auth/usecases/params/user_details_params.dart';
import 'package:cinequest/src/domain/auth/usecases/setup_account_usecase.dart';
import 'package:cinequest/src/presentation/auth/blocs/account_setup/account_setup_bloc.dart';
import 'package:cinequest/src/presentation/auth/widgets/account_setup/as_bio_view.dart';
import 'package:cinequest/src/presentation/auth/widgets/account_setup/as_fullname_view.dart';
import 'package:cinequest/src/presentation/auth/widgets/account_setup/as_profile_photo_view.dart';
import 'package:cinequest/src/presentation/auth/widgets/account_setup/as_username_view.dart';
import 'package:cinequest/src/presentation/auth/widgets/account_setup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '_mixins/account_setup_page.mixin.dart';

class AccountSetupPage extends StatelessWidget {
  const AccountSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AccountSetupBloc(),
        ),
        BlocProvider(
          create: (context) => ButtonBloc(),
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
    return BlocBuilder<AccountSetupBloc, AccountSetupState>(
      buildWhen: (previous, current) =>
          previous.currentPage != current.currentPage ||
          previous.profilePhoto != current.profilePhoto,
      builder: (context, state) {
        final profilePhoto = state.profilePhoto;
        return BlocConsumer<ButtonBloc, ButtonState>(
          listener: _listener,
          builder: (context, state) {
            return AccountSetupView(
              onNext: () => _next(profilePhoto),
              onBack: _back,
              isLoading: state == const ButtonState.loading(),
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: _changePage,
                children: [
                  ASUsernameView(
                    title: 'Customize your account'.hardcoded,
                    subtitle:
                        'Your CineQuest Voice: Choose a Name to Share Your Reviews and Thoughts'
                            .hardcoded,
                    formKey: _usernameFormKey,
                    usernameTextEditingController:
                        _usernameTextEditingController,
                    onUsernameChanged: _changeUsername,
                  ),
                  ASFullnameView(
                    title: 'Customize your account'.hardcoded,
                    formKey: _fullNameCodeFormKey,
                    nameTextEditingController: _nameTextEditingController,
                    onNameChanged: (value) => context
                        .read<AccountSetupBloc>()
                        .add(AccountSetupEvent.nameChanged(name: value)),
                    surnameTextEditingController: _surnameTextEditingController,
                    onSurnameChanged: _changeSurname,
                  ),
                  ASBioView(
                    title: 'Share Your Story:\nCreate Your Bio'.hardcoded,
                    formKey: _bioFormKey,
                    bioTextEditingController: _bioTextEditingController,
                    onChanged: _changeBio,
                  ),
                  ASProfilePhotoView(
                    title: "Snap a Selfie: Let's Put a Face to Your Name!"
                        .hardcoded,
                    onPressed: _changePhoto,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
