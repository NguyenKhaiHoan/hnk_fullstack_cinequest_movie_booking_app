import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_text_field.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/validation_util.dart';
import 'package:cinequest/src/presentation/auth/blocs/account_setup/account_setup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ASBioView extends StatelessWidget {
  const ASBioView({
    required this.title,
    required this.formKey,
    required this.bioTextEditingController,
    super.key,
    this.onChanged,
  });

  final String title;
  final void Function(String)? onChanged;
  final GlobalKey<FormState> formKey;
  final TextEditingController bioTextEditingController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountSetupBloc, AccountSetupState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(context),
            gapH24,
            _buildForm(state),
          ],
        );
      },
    );
  }

  Form _buildForm(AccountSetupState state) {
    return Form(
      key: formKey,
      child: CustomTextField(
        label: 'Bio'.hardcoded,
        controller: bioTextEditingController,
        onChanged: onChanged,
        checkCharacterCounter: true,
        counter: state.bio.length,
        validator: (value) => ValidationUtil.validateEmptyField('Bio', value),
      ),
    );
  }

  Text _buildTitle(BuildContext context) {
    return Text(
      title,
      style: context.textTheme.headlineMedium,
    );
  }
}
