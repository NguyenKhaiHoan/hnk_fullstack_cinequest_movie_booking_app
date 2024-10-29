import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/src/common/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class LocationItem extends StatelessWidget {
  const LocationItem({
    required this.cityName,
    required this.isSelected,
    super.key,
  });

  final String cityName;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(cityName),
          const Spacer(),
          if (isSelected) SvgIcon(iconPath: AppAssets.images.check.path),
        ],
      ),
    );
  }
}
