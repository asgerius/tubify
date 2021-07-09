import 'package:flutter/material.dart';
import 'package:tubify/system/persistent.dart';
import 'package:tubify/widgets/content.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'player_screen_state.dart';


class PlayerScreenView extends PlayerScreenState {

  @override
  Widget build(BuildContext context) => safeAreaWithBG(
    context,
    Scaffold(
      body: padLR(this._buildBody()),
    ),
  );

  Widget _buildBody() => Column(
    children: [
      if (this.controller != null)
        YoutubePlayer(
          controller: this.controller!,
        ),
      Container(
        height: 0.5 * safeHeight(context),
        child: ListView(
          children: persistent.ids.map(
            (e) => Text(e),
          ).toList(),
        ),
      ),
    ],
  );
}
