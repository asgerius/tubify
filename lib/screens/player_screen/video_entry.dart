import 'package:flutter/material.dart';
import 'package:tubify/system/persistent.dart';


class VideoEntry extends StatelessWidget {

  final String id;
  final void Function() onDelete;
  final bool isPlaying;

  VideoEntry(this.id, this.onDelete, { this.isPlaying = false });

  @override
  Widget build(BuildContext context) => Container(
    decoration: this.isPlaying ? BoxDecoration(
      border: Border.all(color: Color(0xFFAAAAAA)),
      borderRadius: BorderRadius.circular(8),
    ) : null,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(this.id),
          GestureDetector(
            child: Icon(Icons.delete_outline_outlined),
            behavior: HitTestBehavior.opaque,
            onTap: () {
              persistent.removeID(id);
              this.onDelete();
            },
          ),
        ],
      ),
    ),
  );
}
