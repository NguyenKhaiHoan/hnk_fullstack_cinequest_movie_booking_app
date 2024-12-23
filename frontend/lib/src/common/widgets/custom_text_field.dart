import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/blocs/text_field/text_field_bloc.dart';
import 'package:cinequest/src/common/widgets/svg_icon.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.label,
    required this.controller,
    super.key,
    this.isPassword = false,
    this.isVerificationCode = false,
    this.onChanged,
    this.validator,
    this.checkCharacterCounter = false,
    this.counter = 0,
    this.prefixIconPath,
  });

  final String label;
  final bool isPassword;
  final bool isVerificationCode;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool checkCharacterCounter;
  final int counter;
  final String? prefixIconPath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TextFieldBloc(),
      child: BlocBuilder<TextFieldBloc, TextFieldState>(
        builder: (context, state) {
          return TextFormField(
            controller: controller,
            obscureText: isPassword && state.obscure,
            style: context.textTheme.bodyMedium,
            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
              labelText: label.toUpperCase(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              counter: checkCharacterCounter
                  ? Text.rich(
                      TextSpan(
                        text: counter.toString(),
                        style: context.textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: '/120'.hardcoded,
                            style: context.textTheme.bodyMedium!
                                .copyWith(color: AppColors.dimGray),
                          ),
                        ],
                      ),
                    )
                  : null,
              prefix: prefixIconPath != null
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: SvgIcon(
                        iconPath: prefixIconPath!,
                        colorFilter: const ColorFilter.mode(
                          AppColors.dimGray,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  : null,
              suffixIcon: isPassword
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: SvgIcon(
                        iconPath: state.obscure
                            ? AppAssets.images.eyeSlash.path
                            : AppAssets.images.eye.path,
                        colorFilter: const ColorFilter.mode(
                          AppColors.dimGray,
                          BlendMode.srcIn,
                        ),
                        onPressed: () => context
                            .read<TextFieldBloc>()
                            .add(const TextFieldEvent.toggleVisibility()),
                      ),
                    )
                  : null,
            ),
            keyboardType:
                isVerificationCode ? TextInputType.number : TextInputType.text,
          );
        },
      ),
    );
  }
}
