import 'package:aura/functions/universal_functions.dart';
import 'package:aura/screens/playlist_scrn.dart';
import 'package:aura/screens/splash_screen.dart';
import 'package:aura/songs/playlist.dart';
import 'package:flutter/material.dart';

class PlaylistIcon extends StatefulWidget {
  EachPlaylist playlist;
  int index;
  int currentplaylistindex;
  PlaylistIcon(
      {super.key,
      required this.playlist,
      required this.index,
      required this.currentplaylistindex});
  @override
  State<PlaylistIcon> createState() => _PlaylistIconState();
}

class _PlaylistIconState extends State<PlaylistIcon> {
  late bool isadded;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isadded = widget.playlist.container.contains(allsongs[widget.index]);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            if (!playListNotifier.value[widget.currentplaylistindex].container
                .contains(allsongs[widget.index])) {
              playListNotifier.value[widget.currentplaylistindex].container
                  .add(allsongs[widget.index]);
              playlistaddDB(allsongs[widget.index],
                  playListNotifier.value[widget.currentplaylistindex].name);
              isadded = true;
            } else {
              playListNotifier.value[widget.currentplaylistindex].container
                  .remove(allsongs[widget.index]);
              playlistremoveDB(allsongs[widget.index], widget.playlist.name);
              isadded = false;
            }
          });
          playListNotifier.notifyListeners();
        },
        icon: isadded
            ? Icon(
                Icons.remove,
                size: 30,
                color: Colors.white,
              )
            : Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ));
  }
}
