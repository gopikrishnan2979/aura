import 'package:aura/common_widget/favoritewidget.dart';
import 'package:aura/common_widget/listtilecustom.dart';
import 'package:aura/screens/commonscreen/add_to_playlist.dart';
import 'package:aura/songs/songs.dart';
import 'package:flutter/material.dart';

ValueNotifier<List<Songs>> favorite = ValueNotifier([]);

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 30, 124),
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.centerLeft,
              colors: [Color(0xFF000000), Color(0xFF0B0E38), Color(0xFF202EAF)],
            ),
          ),
          child: ValueListenableBuilder(
            valueListenable: favorite,
            builder: (context, value, child) => favorite.value.isEmpty
                ? const Center(
                    child: Text(
                      'Favorite List is empty',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: MediaQuery.of(context).size.height * 0.1),
                    itemCount: favorite.value.length,
                    itemBuilder: (context, index) => ListTileCustom(
                      index: index,
                      context: context,
                      leading: Image.asset('assets/images/audiobg.png'),
                      tilecolor: const Color(0xFF939DF5),
                      title: Text(
                        favorite.value[index].songname ?? 'Unknown',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis),
                      ),
                      subtitle: Text(
                        favorite.value[index].artist != null
                            ? '${favorite.value[index].artist}'
                            : 'Unknown',
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                      trailing1: FavoriteButton(
                        isfav: true,
                        currentSong: favorite.value[index],
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
                              AddToPlaylist(addingsong: favorite.value[index]),
                        )),
                      ),
                    ),
                  ),
          )),
    );
  }
}
