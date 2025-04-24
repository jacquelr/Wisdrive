// video_player_screen.dart
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoMecanic extends StatefulWidget {
  final String url;

  const VideoMecanic({super.key, required this.url});

  @override
  State<VideoMecanic> createState() => _VideoMecanicState();
}

class _VideoMecanicState extends State<VideoMecanic> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(widget.url)!;
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: true),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: _controller),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(title: const Text("Video")),
          body: Center(child: player),
        );
      },
    );
  }
}
