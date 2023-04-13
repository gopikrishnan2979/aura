
import 'package:aura/common_widget/inside_playlist_part1.dart';
import 'package:aura/common_widget/inside_playlist_part2.dart';

import 'package:aura/common_widget/playlist_icon_playlist_text.dart';

import 'package:aura/screens/playlist_scrn.dart';

import 'package:aura/screens/splash_screen.dart';

import 'package:flutter/material.dart';

class InsidePlaylist extends StatelessWidget {

  final int currentplaylistindex;
  const InsidePlaylist(
      {super.key, required this.currentplaylistindex});

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
          child: ValueListenableBuilder(
            valueListenable: playListNotifier,
            builder: (context, value, child) => Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 30,
                              )),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(9)),
                                    backgroundColor: Color(0xFF202EAF),
                                    context: context,
                                    builder: (context) =>
                                        bottomsheetallsongs(context));
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30,
                              ),)
                        ],
                      ),
                    ),
                  ),
                ),
                PlaylistInsidePart1(currentplaylistindex: currentplaylistindex),
                playListNotifier.value[currentplaylistindex].container.isEmpty
                    ? const Expanded(
                        child: SizedBox(
                          child: Center(
                            child: Text(
                              'No songs in playlist, add songs',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      )
                    : PlaylistInsidePart2(

                        currentplaylistindex: currentplaylistindex,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bottomsheetallsongs(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: Color(0xFF939DF5),
              title: Text(
                allsongs[index].songname!,
                style: const TextStyle(color: Color(0xFF202EAF)),
              ),
              trailing: PlaylistIcon(
                  playlist: playListNotifier.value[currentplaylistindex],
                  index: index,
                  currentplaylistindex: currentplaylistindex),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
            ),
          );
        },
        itemCount: allsongs.length,
      ),
    );
  }
}
