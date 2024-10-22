import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_text_field.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/validation_util.dart';
import 'package:flutter/material.dart';

class ASFullnameView extends StatelessWidget {
  const ASFullnameView({
    required this.title,
    required this.formKey,
    required this.nameTextEditingController,
    required this.surnameTextEditingController,
    super.key,
    this.onNameChanged,
    this.onSurnameChanged,
  });

  final String title;
  final void Function(String)? onNameChanged;
  final void Function(String)? onSurnameChanged;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameTextEditingController;
  final TextEditingController surnameTextEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context),
        gapH24,
        _buildForm(),
      ],
    );
  }

  Text _buildTitle(BuildContext context) {
    return Text(
      title,
      style: context.textTheme.headlineMedium,
    );
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            label: 'Name'.hardcoded,
            controller: nameTextEditingController,
            onChanged: onNameChanged,
            validator: (value) =>
                ValidationUtil.validateEmptyField('Name'.hardcoded, value),
          ),
          gapH16,
          CustomTextField(
            label: 'Surname'.hardcoded,
            controller: surnameTextEditingController,
            onChanged: onSurnameChanged,
            validator: (value) =>
                ValidationUtil.validateEmptyField('Surname'.hardcoded, value),
          ),
        ],
      ),
    );
  }
}
