import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:aura/common_widget/favoritewidget.dart';
import 'package:aura/common_widget/listtilecustom.dart';
import 'package:aura/functions/universal_functions.dart';
import 'package:aura/screens/favorite.dart';
import 'package:aura/screens/homescreen.dart';
import 'package:aura/screens/play_screen.dart';
import 'package:aura/screens/playlist_scrn.dart';

import 'package:aura/songs/playlist.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistInsidePart2 extends StatelessWidget {
  final int currentplaylistindex;
  const PlaylistInsidePart2({super.key, required this.currentplaylistindex});

  @override
  Widget build(BuildContext context) {
    final playlist = playListNotifier.value[currentplaylistindex];
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: InkWell(
              onTap: () {
                player.stop();
                playinglistAudio.clear();
                for (int i = 0;
                    i <
                        playListNotifier
                            .value[currentplaylistindex].container.length;
                    i++) {
                  playinglistAudio.add(Audio.file(
                      playListNotifier
                          .value[currentplaylistindex].container[i].songurl!,
                      metas: Metas(
                        title: playListNotifier
                            .value[currentplaylistindex].container[i].songname,
                        artist: playListNotifier
                            .value[currentplaylistindex].container[i].artist,
                        id: playListNotifier
                            .value[currentplaylistindex].container[i].id
                            .toString(),
                      )));
                }

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => PlayingScreen(
                      playinglistSongs: playListNotifier
                          .value[currentplaylistindex].container,
                      index: index),
                ));
              },
              child: listtile(context, index, playlist),
            ),
          ),
          itemCount:
              (playListNotifier.value[currentplaylistindex].container).length,
        ),
      ),
    );
  }

  listtile(BuildContext context, int idx, EachPlaylist playlist) {
    return ListTileCustom(
      context: context,
      index: idx,
      leading: QueryArtworkWidget(
        size: 3000,
        quality: 100,
        artworkQuality: FilterQuality.high,
        artworkBorder: BorderRadius.circular(10),
        artworkFit: BoxFit.cover,
        id: playlist.container[idx].id,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Image.asset(
            'assets/images/Happier.png',
          ),
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
