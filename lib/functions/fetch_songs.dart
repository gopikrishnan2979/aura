import 'package:aura/database/favorite/dbmodel/fav_model.dart';
import 'package:aura/database/playlist/playlistmodel/playlist_model.dart';
import 'package:aura/screens/favorite.dart';
import 'package:aura/screens/playlist_scrn.dart';
import 'package:aura/screens/splash_screen.dart';
import 'package:aura/songs/playlist.dart';
import 'package:aura/songs/songs.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FetchSongs {
  final OnAudioQuery audioquerry = OnAudioQuery();
  requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  songfetch() async {
    bool status = await requestPermission();
    if (status) {
      List<SongModel> fetchsongs = await audioquerry.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL);
      for (SongModel element in fetchsongs) {
        if (element.fileExtension == "mp3") {
          allsongs.add(Songs(
              songname: element.displayNameWOExt,
              artist: element.artist,
              duration: element.duration,
              id: element.id,
              songurl: element.uri));
        }
      }
      List<FavModel> favsongcheck = [];
      Box<FavModel> favdb = await Hive.openBox('favorite');
      favsongcheck.addAll(favdb.values);
      for (var favs in favsongcheck) {
        int count = 0;
        for (var songs in allsongs) {
          if (favs.id == songs.id) {
            favorite.value.add(songs);
            break;
          } else {
            count++;
          }
        }
        if (count == allsongs.length) {
          var key = favs.key;
          favdb.delete(key);
        }
      }
      favdb.close();
      Box<PlaylistClass> playlistdb = await Hive.openBox('playlist');
      for (PlaylistClass elements in playlistdb.values) {
        String playlistname = elements.playlistName;
        EachPlaylist playlistfetch = EachPlaylist(name: playlistname);
        for (int id in elements.items) {
          for (Songs songs in allsongs) {
            if (id == songs.id) {
              playlistfetch.container.add(songs);
              break;
            }
          }
        }
        playListNotifier.value.add(playlistfetch);
      }
      playlistdb.close();
    }
  }
}
