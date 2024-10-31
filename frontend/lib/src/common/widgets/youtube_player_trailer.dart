import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerTrailers extends StatelessWidget {
  const YoutubePlayerTrailers({
    required YoutubePlayerController controller,
    super.key,
  }) : _controller = controller;

  final YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onEnterFullScreen: () {},
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        bottomActions: [
          const CurrentPosition(),
          const ProgressBar(
            isExpanded: true,
            colors: ProgressBarColors(
              playedColor: AppColors.white,
              handleColor: AppColors.white,
            ),
          ),
          const FullScreenButton(),
          PlayPauseButton(
            controller: _controller,
          ),
        ],
      ),
      builder: (_, player) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          child: player,
        );
      },
    );
  }
}
