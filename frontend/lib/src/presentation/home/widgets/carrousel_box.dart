import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselBox extends StatelessWidget {
  const CarouselBox({
    required this.maxHeight,
    required this.children,
    super.key,
  });

  final double maxHeight;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight, minHeight: maxHeight),
      child: CarouselSlider(
        options: CarouselOptions(
          height: maxHeight,
          enlargeCenterPage: true,
          autoPlay: true,
          disableCenter: true,
        ),
        items: children,
      ),
    );
  }
}
