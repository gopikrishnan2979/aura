import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:aura/common_widget/favoritewidget.dart';
import 'package:aura/screens/favorite.dart';
import 'package:aura/songs/songs.dart';
import 'package:flutter/material.dart';
import 'package:aura/screens/splash_screen.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayingScreen extends StatefulWidget {
  final Songs playing;
  const PlayingScreen({super.key, required this.playing});

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

AssetsAudioPlayer? currentplaying;

class _PlayingScreenState extends State<PlayingScreen> {
  AssetsAudioPlayer player = AssetsAudioPlayer();
  bool isplaying = true;
  @override
  void initState() {
    super.initState();
    player.open(
        Audio.file(widget.playing.songurl!,
            metas: Metas(
              title: widget.playing.songname,
              artist: widget.playing.artist,
              id: widget.playing.id.toString(),
            )),
        autoStart: true,
        showNotification: true,
        seek: Duration(minutes: widget.playing.duration!));
    currentplaying = player;
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
            : Column(
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
                              artworkQuality: FilterQuality.high,
                              artworkBorder: BorderRadius.circular(10),
                              artworkFit: BoxFit.cover,
                              id: widget.playing.id,
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
                              text: widget.playing.songname!,
                              pauseAfterRound: const Duration(seconds: 3),
                              velocity: 50,
                              blankSpace: 30,
                              style: const TextStyle(
                                  fontSize: 25.0, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.playing.artist
                                          .toString()
                                          .split(" ")[0]
                                          .length >
                                      20
                                  ? '<Unknown>'
                                  : widget.playing.artist
                                      .toString()
                                      .split(" ")[0],
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.shuffle,
                                      size: 35,
                                      color: Colors.white,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
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
                        ProgressBar(
                          timeLabelTextStyle: TextStyle(color: Colors.white),
                          baseBarColor: Colors.black,
                          bufferedBarColor: Colors.black,
                          progressBarColor: Colors.white,
                          thumbColor: Colors.white,
                          thumbRadius: 8,
                          thumbGlowRadius: 20,
                          progress: Duration(minutes: 3),
                          buffered: Duration(milliseconds: 0),
                          total: Duration(minutes: 5),
                          onSeek: (duration) {
                            print('User selected a new time: $duration');
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
                                    isfav:
                                        favorite.value.contains(widget.playing),
                                    currentSong: widget.playing)),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.skip_previous_rounded,
                                  size: 50,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () async {
                                  if (isplaying) {
                                    isplaying = false;
                                    await player.playOrPause();
                                  } else {
                                    isplaying = true;
                                    await player.playOrPause();
                                  }
                                  setState(() {});
                                },
                                icon: Icon(
                                  isplaying
                                      ? Icons.pause_circle
                                      : Icons.play_circle,
                                  size: 50,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.skip_next_rounded,
                                  size: 50,
                                  color: Colors.white,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: IconButton(
                                  onPressed: () {},
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
              ),
      ),
    ));
  }
}
