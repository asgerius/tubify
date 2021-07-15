import 'package:flutter/material.dart';
import 'package:tubify/screens/player_screen/player_screen.dart';
import 'package:tubify/system/persistent.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


abstract class PlayerScreenState extends State<PlayerScreen> with WidgetsBindingObserver {

  YoutubePlayerController? controller;
  int currentID = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    this.update();
  }

  void update() {
    if (persistent.ids.isNotEmpty && this.controller == null) {
      this.controller = YoutubePlayerController(initialVideoId: persistent.ids[this.currentID]);
    } else if (persistent.ids.isEmpty) {
      this.controller = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    this.controller?.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    // Resume playing when minimized
    if (
      (state == AppLifecycleState.inactive || state == AppLifecycleState.detached || state == AppLifecycleState.paused)
      && (this.controller?.value.isPlaying ?? true)
    ) {
      await Future.delayed(Duration(seconds: 1));
      this.controller?.play();
    }
  }
}
