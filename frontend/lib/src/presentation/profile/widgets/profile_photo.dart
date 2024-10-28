import 'dart:convert';

import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/entities/user_details.dart';
import 'package:cinequest/src/common/service/user_details_stream_service.dart';
import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    var useDetailsStreamService = sl<UserDetailsStreamService>();
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: StreamBuilder<UserDetails?>(
          stream: useDetailsStreamService.userDetailsStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: AppColors.white,
              );
            }

            if (snapshot.hasError && snapshot.data == null) {
              return _buildMessage('Error when loading data user'.hardcoded);
            }

            final userDetails = snapshot.data;
            return _buildUserProfile(context, userDetails!);
          },
        ),
      ),
    );
  }

  Widget _buildMessage(String message) {
    return SizedBox(
      child: Center(
        child: Text(message.hardcoded),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, UserDetails userDetails) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: MemoryImage(
                  base64Decode(
                    userDetails.profilePhoto!
                        .replaceFirst('data:image/jpeg;base64,', ''),
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          gapH8,
          Text(
            '${userDetails.surname} ${userDetails.name}',
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
