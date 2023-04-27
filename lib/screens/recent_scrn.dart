import 'package:aura/common_widget/favoritewidget.dart';
import 'package:aura/common_widget/listtilecustom.dart';
import 'package:aura/functions/player_function.dart';
import 'package:aura/screens/commonscreen/add_to_playlist.dart';
import 'package:aura/screens/favorite.dart';
import 'package:aura/screens/mini_player.dart';
import 'package:aura/songs/songs.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';


ValueNotifier<List<Songs>> recentList=ValueNotifier([]);

class RecentScrn extends StatelessWidget {
  const RecentScrn({super.key});

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
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          )),
                      const Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Text(
                          'RECENT',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ValueListenableBuilder(valueListenable: recentList, builder: (context, value, child) => Expanded(
                child: listtilebuilder(),
              ),)
            ],
          ),
        ),
      ),
    );
  }

  Widget songlistempty() {
    return const Center(
      child: Text(
        'No songs in recent',
        style: TextStyle(color: Colors.grey, fontSize: 20),
      ),
    );
  }

  Widget listtilebuilder() {
    return recentList.value.isEmpty
        ? songlistempty()
        : ListView.builder(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 30),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                playAudio(recentList.value, index);
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: const Color(0xFF202EAF),
                    builder: (context) => const MiniPlayer());
              },
              child: ListTileCustom(
                index: index,
                context: context,
                leading: QueryArtworkWidget(
                  size: 3000,
                  quality: 100,
                  artworkQuality: FilterQuality.high,
                  artworkBorder: BorderRadius.circular(10),
                  artworkFit: BoxFit.cover,
                  id: recentList.value[index].id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.asset(
                      'assets/images/Happier.png',
                    ),
                  ),
                ),
                tilecolor: const Color(0xFF939DF5),
                title: Text(
                  recentList.value[index].songname!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 15),
                ),
                subtitle: Text(recentList.value[index].artist!,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis, fontSize: 12)),
                trailing1: FavoriteButton(
                    isfav: favorite.value.contains(recentList.value[index]),
                    currentSong: recentList.value[index]),
                trailing2: Theme(
                  data: Theme.of(context)
                      .copyWith(cardColor: const Color(0xFF87BEFF)),
                  child: PopupMenuButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      itemBuilder: (context) =>
                          [const PopupMenuItem(child: Text('Add to playlist'))],
                      onSelected: (value) =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                AddToPlaylist(addingsong: recentList.value[index]),
                          ))),
                ),
              ),
            ),
            itemCount: recentList.value.length,
          );
  }
}
