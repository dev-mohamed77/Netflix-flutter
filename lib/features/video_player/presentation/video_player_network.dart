import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:netflix/core/extensions/responsive_size_extensions.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';

class VideoPlayerNetworkScreen extends StatefulWidget {
  const VideoPlayerNetworkScreen({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  State<VideoPlayerNetworkScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerNetworkScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BetterPlayer.network(
        widget.videoUrl,
        betterPlayerConfiguration: BetterPlayerConfiguration(
          autoPlay: true,
          overlay: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Netflix",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColorsManager.accentColor,
              ),
            ),
          ),
          autoDispose: true,
          aspectRatio: context.width / (context.width / 1.4),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
