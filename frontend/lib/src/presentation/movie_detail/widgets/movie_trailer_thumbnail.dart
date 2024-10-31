import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/youtube_player_trailer.dart';
import 'package:cinequest/src/core/extensions/int_extension.dart';
import 'package:cinequest/src/domain/movie/entities/video.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerThumbnail extends StatefulWidget {
  const MovieTrailerThumbnail({super.key, required this.video});
  final Video video;

  @override
  State<MovieTrailerThumbnail> createState() => _MovieTrailerThumbnailState();
}

class _MovieTrailerThumbnailState extends State<MovieTrailerThumbnail> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.key!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          child: SizedBox(
            height: 250,
            width: 300,
            child: YoutubePlayerTrailers(controller: _controller),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: Text(
            'Trailer · ${_controller.metadata.duration.inSeconds.formatSeconds()}',
          ),
        ),
      ],
    );
  }
}
