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
    wait();
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

  wait() async {
    FetchSongs fetchsong = FetchSongs();
    await fetchsong.songfetch();
    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const NavigatorScrn(),
      ));
    });
  }
}
