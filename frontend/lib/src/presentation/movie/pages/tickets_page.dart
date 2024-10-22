import 'package:cinequest/src/common/widgets/app_bar_bottom_divider.dart';
import 'package:cinequest/src/common/widgets/padding_app_bar.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/date_time_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final time = DateTime.now();
    return Scaffold(
      appBar: AppBarBottomDivider(
        leadingWidth: 110,
        leading: PaddingAppBar(
          isLeft: true,
          alignment: Alignment.centerLeft,
          child: Text(
            time.formatToMMMDD().toUpperCase().hardcoded,
            style: context.textTheme.bodyMedium,
          ),
        ),
        actions: [
          PaddingAppBar(
            isLeft: false,
            child: Text(
              'Tickets'.toUpperCase().hardcoded,
              style: context.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text('Tickets Page'),
      ),
    );
  }
}
