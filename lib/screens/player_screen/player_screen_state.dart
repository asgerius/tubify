import 'package:flutter/material.dart';
import 'package:tubify/screens/player_screen/player_screen.dart';
import 'package:tubify/system/persistent.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


abstract class PlayerScreenState extends State<PlayerScreen> with WidgetsBindingObserver {

  YoutubePlayerController? controller;

  @override
  void initState() {
    super.initState();
    this.updateController(persistent.ids[0]);
    for (int i = 1; i < persistent.ids.length; i ++) {
      this.controller!.cue(persistent.ids[i]);
    }
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.detached || state == AppLifecycleState.paused) {
      await Future.delayed(Duration(seconds: 1));
      this.controller?.play();
    }
  }

  Future<void> updateController(String id) async {
    setState(() {
      this.controller = YoutubePlayerController(initialVideoId: id);
    });
  }
}
