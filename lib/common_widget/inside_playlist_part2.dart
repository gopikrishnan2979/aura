import 'package:aura/common_widget/favoritewidget.dart';
import 'package:aura/common_widget/listtilecustom.dart';
import 'package:aura/functions/universal_functions.dart';
import 'package:aura/screens/favorite.dart';
import 'package:aura/screens/playlist_scrn.dart';
import 'package:flutter/material.dart';

class PlaylistInsidePart2 extends StatelessWidget {
  final int currentplaylistindex;
  const PlaylistInsidePart2({super.key, required this.currentplaylistindex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: ListView.builder(
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: listtile(context, index),
          ),
          itemCount:
              playListNotifier.value[currentplaylistindex].container.length,
        ),
      ),
    );
  }

  listtile(BuildContext context, int idx) {
    return ListTileCustom(
      context: context,
      index: idx,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Image.asset(
          'assets/images/audiobg.png',
        ),
      ),
      title: Text(
        playListNotifier.value[currentplaylistindex].container[idx].songname ??
            'Unknown',
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            overflow: TextOverflow.ellipsis),
      ),
      subtitle: Text(
        playListNotifier.value[currentplaylistindex].container[idx].artist !=
                null
            ? '${playListNotifier.value[currentplaylistindex].container[idx].artist}'
            : 'Unknown',
        style: const TextStyle(overflow: TextOverflow.ellipsis),
      ),
      trailing1: FavoriteButton(
        isfav: favorite.value.contains(
            playListNotifier.value[currentplaylistindex].container[idx]),
        currentSong:
            playListNotifier.value[currentplaylistindex].container[idx],
      ),
      trailing2: PopupMenuButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 0,
            child: Text(
              'Remove from playlist',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
        onSelected: (value) {
          if (value == 0) {
            playListNotifier.value[currentplaylistindex].container.remove(
                playListNotifier.value[currentplaylistindex].container[idx]);
            playlistremoveDB(
                playListNotifier.value[currentplaylistindex].container[idx],
                playListNotifier.value[currentplaylistindex].name);

          }
          playListNotifier.notifyListeners();
        },
      ),
      tilecolor: const Color(0xFF939DF5),
    );
  }
}
