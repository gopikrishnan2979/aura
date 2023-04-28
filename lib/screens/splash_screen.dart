import 'dart:async';
import 'package:aura/functions/fetch_songs.dart';
import 'package:aura/screens/navigator_scr.dart';
import 'package:flutter/material.dart';
import 'package:aura/songs/songs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

List<Songs> allsongs = [];

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 2010), () async {
      FetchSongs fetchsong = FetchSongs();
      await fetchsong.songfetch();
      if (!context.mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const NavigatorScrn(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/images/AURA.gif'),
      ),
    );
  }
}
