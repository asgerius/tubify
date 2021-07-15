import 'package:flutter/material.dart';
import 'package:tubify/screens/player_screen/video_entry.dart';
import 'package:tubify/system/persistent.dart';
import 'package:tubify/theme.dart';
import 'package:tubify/widgets/content.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'player_screen_state.dart';


class PlayerScreenView extends PlayerScreenState {

  @override
  Widget build(BuildContext context) => safeAreaWithBG(
    context,
    Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: DEFAULT_LEFTRIGHT, right: DEFAULT_LEFTRIGHT, top: 24, bottom: 24),
        child: this._buildBody(),
      ),
      floatingActionButton: this._buildFAB(),
    ),
  );

  Widget _buildBody() => Column(
    children: [
      Align(
        alignment: Alignment.topCenter,
        child: Text("Tubify", style: textTheme.headline1),
      ),
      SizedBox(height: 24),

      if (this.controller != null)
        YoutubePlayer(
          controller: this.controller!,
          onEnded: (metadata) {
            this.currentID ++;
            if (this.currentID >= persistent.ids.length)
              this.currentID = 0;
            this.controller?.load(persistent.ids[this.currentID]);
          },
        ),

      SizedBox(height: 24),
      Container(
        height: 0.5 * safeHeight(context),
        child: Scrollbar(
          child: ListView(
            children: persistent.ids.map(
              (id) => VideoEntry(
                id,
                () {
                  this.setState(() {});
                  this.update();
                },
                isPlaying: persistent.ids[this.currentID] == id,
              ),
            ).toList(),
          ),
        ),
      ),
    ],
  );

  Widget _buildFAB() => FloatingActionButton(
    child: Icon(Icons.add),
    onPressed: () async {
      String? id = await showDialog<String?>(
        context: context,
        builder: (BuildContext context) {
          final controller = TextEditingController();
          return Dialog(
            child: Container(
              height: 0.3 * safeHeight(context),
              width: 0.7 * MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Add new link or ID below", style: textTheme.headline6),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Enter a url or video ID",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(controller.text),
                          child: Text("Ok"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        },
      );
      id = YoutubePlayer.convertUrlToId(id ?? "");
      if (id != null) {
        await persistent.addID(id);
        setState(() {});
        this.update();
      }
    },
  );
}
