import 'package:hive_flutter/hive_flutter.dart';

mostplayedaddtodb(int id) async {
  Box<int> mostplayedDb = await Hive.openBox('mostplayed');
  int count = mostplayedDb.get(id)!;
  mostplayedDb.put(id, count + 1);
}
