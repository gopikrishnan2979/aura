import 'package:aura/database/favorite/fav_db_function/fav_functions.dart';
import 'package:aura/screens/favorite.dart';
import 'package:aura/screens/most_played_scrn.dart';
import 'package:aura/screens/playlist_scrn.dart';
import 'package:aura/screens/recent_scrn.dart';
import 'package:aura/songs/songs.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FavoriteButton extends StatefulWidget {
  bool isfav = false;
  Songs currentSong;
  Color? color;
  double? size;
  FavoriteButton(
      {super.key,
      required this.isfav,
      required this.currentSong,
      this.color,
      this.size});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          setState(() {
            if (widget.isfav == false) {
              widget.isfav = true;
              addfavorite(widget.currentSong);
              snackbar(text: 'Added to liked', color: Colors.green);
            } else {
              removefavorite(widget.currentSong);
              widget.isfav = false;
              snackbar(text: 'Removed from liked', color: Colors.red);
            }
            favorite.notifyListeners();
            recentList.notifyListeners();
            mostPlayedList.notifyListeners();
            playListNotifier.notifyListeners();
          });
        },
        child: Icon(
          Icons.favorite,
          color: widget.isfav
              ? widget.color ?? const Color(0xFF0812FF)
              : Colors.white,
          size: widget.size ?? 25,
        ));
  }

//liked snackbar
  snackbar({required String text, required color}) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 800),
        margin: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
        behavior: SnackBarBehavior.floating,
        content: Text(text),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ));
  }
}
