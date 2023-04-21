import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:aura/common_widget/favoritewidget.dart';
import 'package:aura/common_widget/playscrnwidget/playscrn_widget.dart';
import 'package:aura/screens/commonscreen/add_to_playlist.dart';
import 'package:aura/screens/favorite.dart';
import 'package:aura/screens/homescreen.dart';

import 'package:aura/songs/songs.dart';
import 'package:flutter/material.dart';
import 'package:aura/screens/splash_screen.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';


int? playingId;
Songs? currentlyplaying;
List<Audio> playinglistAudio = [];

class PlayingScreen extends StatefulWidget {
  final int index;

  final List<Songs> playinglistSongs;
  const PlayingScreen(
      {super.key, required this.playinglistSongs, required this.index});

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openplayer();
  }

  openplayer() async {
    await player.open(
      Playlist(audios: playinglistAudio, startIndex: widget.index),
      autoStart: true,
      showNotification: true,notificationSettings: NotificationSettings(nextEnabled: true, prevEnabled: true,seekBarEnabled: true,playPauseEnabled: true)
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.centerLeft,
            colors: [Color(0xFF000000), Color(0xFF0B0E38), Color(0xFF202EAF)],
          ),
        ),
        child: allsongs.isEmpty
            ? const Center(
                child: Text(
                  'No songs found',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              )
            : player.builderCurrent(
                builder: (context, playing) {
                  playingId = int.parse(playing.audio.audio.metas.id!);
                  for (Songs song in allsongs) {
                    if (song.id == playingId) {
                      currentlyplaying = song;
                      break;
                    }
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 30,
                              )),
                        ),
                      ),
                      SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.07),
                          child: const Text(
                            'Playing',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: SizedBox(
                          child: Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.38,
                              width: MediaQuery.of(context).size.height * 0.38,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height * 0.19),
                                child: QueryArtworkWidget(
                                  size: 3000,
                                  quality: 100,
                                  keepOldArtwork: true,
                                  artworkQuality: FilterQuality.high,
                                  artworkBorder: BorderRadius.circular(10),
                                  artworkFit: BoxFit.cover,
                                  id: int.parse(playing.audio.audio.metas.id!),
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/images/playingbg.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.065,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 30, right: 30, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Marquee(
                                  text: player.getCurrentAudioTitle,
                                  pauseAfterRound: const Duration(seconds: 3),
                                  velocity: 50,
                                  blankSpace: 30,
                                  style: const TextStyle(
                                      fontSize: 25.0, color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  player.getCurrentAudioArtist
                                              .toString()
                                              .split(" ")[0]
                                              .length >
                                          20
                                      ? '<Unknown>'
                                      : player.getCurrentAudioArtist
                                          .toString()
                                          .split(" ")[0],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.shuffle,
                                          size: 35,
                                          color: Colors.white,
                                        )),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.repeat,
                                          size: 35,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            player.builderRealtimePlayingInfos(
                              builder: (context, infos) {
                                Duration currentposition =
                                    infos.currentPosition;
                                Duration totalduration = infos.duration;
                                return ProgressBar(
                                  timeLabelTextStyle:
                                      const TextStyle(color: Colors.white),
                                  baseBarColor: Colors.black,
                                  bufferedBarColor: Colors.black,
                                  progressBarColor: Colors.white,
                                  thumbColor: Colors.white,
                                  thumbRadius: 8,
                                  thumbGlowRadius: 20,
                                  progress: currentposition,
                                  total: totalduration,
                                  onSeek: (duration) {
                                    player.seek(duration);
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: FavoriteButton(
                                        size: 35,
                                        color: const Color(0xFF00FF57),
                                        isfav: favorite.value
                                            .contains(currentlyplaying),
                                        currentSong: currentlyplaying!)),
                                IconButton(
                                    onPressed: () {
                                      Timer(const Duration(milliseconds: 800),
                                          () {});
                                      setState(() {
                                        player.previous();
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.skip_previous_rounded,
                                      size: 50,
                                      color: Colors.white,
                                    )),
                                const PlayPause(),
                                IconButton(
                                    onPressed: () {
                                      Timer(const Duration(milliseconds: 800),
                                          () {});
                                      setState(() {
                                        player.next();
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.skip_next_rounded,
                                      size: 50,
                                      color: Colors.white,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => AddToPlaylist(
                                              addingsong: currentlyplaying!),
                                        ));
                                      },
                                      icon: Icon(
                                        Icons.playlist_add_rounded,
                                        size: 40,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
      ),
    ));
  }
}
