import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:aura/common_widget/favoritewidget.dart';
import 'package:aura/common_widget/listtilecustom.dart';
import 'package:aura/screens/commonscreen/add_to_playlist.dart';
import 'package:aura/screens/favorite.dart';
import 'package:aura/screens/most_played_scrn.dart';
import 'package:aura/screens/play_screen.dart';
import 'package:aura/screens/recent_scrn.dart';
import 'package:aura/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

AssetsAudioPlayer player = AssetsAudioPlayer();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFF202EB0),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.centerLeft,
            colors: [Color(0xFF000000), Color(0xFF0B0E38), Color(0xFF202EAF)],
          ),
        ),
        child: allsongs.isEmpty
            ? songlistempty()
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10, top: 15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                        child: icontextheading(
                            FontAwesomeIcons.layerGroup, 'Library', context),
                      ),
                      Row(
                        // Library row section
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const MostPlayedScrn(),
                              ));
                            },
                            child: librarycard(
                                context: context,
                                imgsrc: 'assets/images/mostplayedbg.png',
                                title: 'Most Played'),
                          ),
                          InkWell(
                            child: librarycard(
                                context: context,
                                imgsrc: 'assets/images/recentbg.png',
                                title: 'Recent'),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const RecentScrn(),
                              ));
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      icontextheading(FontAwesomeIcons.music, 'Songs', context),
                      const SizedBox(
                        height: 10,
                      ),
                      // creates the list in homescreen
                      listtile(),
                      const SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                ),
              ),
      ),
    ));
  }

  Widget icontextheading(icon, String title, context) {
    return Row(
      children: [
        FaIcon(icon, color: const Color(0xFFC8C8C8)),
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.01),
          child: Text(title,
              style: const TextStyle(color: Color(0xFFC8C8C8), fontSize: 23)),
        )
      ],
    );
  }

//Library
  Widget librarycard(
      {required context, required String imgsrc, required String title}) {
    return Card(
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imgsrc,
              width: MediaQuery.of(context).size.width * 0.35,
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF0C1242),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.width * 0.1,
                child: Center(
                  child: Text(
                    title,
                    style:
                        const TextStyle(color: Color(0xFFE8E8E8), fontSize: 18),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  songlistempty() {
    return const Center(
      child: Text(
        'No songs found (Check permission)',
        style: TextStyle(color: Colors.grey, fontSize: 20),
      ),
    );
  }

  listtile() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      //count of tile
      itemBuilder: (context, index) => InkWell(
          onTap: () {
            player.stop();
            playinglistAudio.clear();
            for (int i = 0; i < allsongs.length; i++) {
              playinglistAudio.add(Audio.file(allsongs[i].songurl!,
                  metas: Metas(
                    title: allsongs[i].songname,
                    artist: allsongs[i].artist,
                    id: allsongs[i].id.toString(),
                  )));
            }

            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  PlayingScreen(playinglistSongs: allsongs, index: index),
            ));
          },
          child: ListTileCustom(
            context: context,
            index: index,
            leading: QueryArtworkWidget(
              size: 3000,
              quality: 100,
              artworkQuality: FilterQuality.high,
              artworkBorder: BorderRadius.circular(10),
              artworkFit: BoxFit.cover,
              id: allsongs[index].id,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.asset(
                  'assets/images/Happier.png',
                ),
              ),
            ),
            title: Text(
              allsongs[index].songname ?? 'Unknown',
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              allsongs[index].artist != null
                  ? '${allsongs[index].artist}'
                  : 'Unknown',
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing1: FavoriteButton(
              isfav: favorite.value.contains(allsongs[index]),
              currentSong: allsongs[index],
            ),
            trailing2: PopupMenuButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 0,
                  child: Text(
                    'Add to playlist',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
              onSelected: (value) =>
                  Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    AddToPlaylist(addingsong: allsongs[index]),
              )),
            ),
            tilecolor: const Color(0xFF939DF5),
          )),
      itemCount: allsongs.length,
    );
  }
}
