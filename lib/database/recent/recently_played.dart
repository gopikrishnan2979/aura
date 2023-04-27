import 'package:hive_flutter/hive_flutter.dart';

recentlyPlayed(int id) async {
  Box<int> recentDb = await Hive.openBox('recent');
  recentDb.add(id);
  
}
