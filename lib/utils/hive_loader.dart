import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../quests/models/todo_item.dart';
import '../dungeon/models/room_state.dart';
import '../dungeon/models/dungeon_save.dart';
import '../character/player.dart';

class HiveLoader {
  HiveLoader._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    await Hive.initFlutter();

    // Register
    Hive.registerAdapter(TodoItemAdapter());    // typeId 00
    Hive.registerAdapter(QuestTypeAdapter());   // typeId 01
    Hive.registerAdapter(RoomStateAdapter());   // typeId 10
    Hive.registerAdapter(DungeonSaveAdapter()); // typeId 11
    Hive.registerAdapter(PlayerAdapter());      // typeId 30

    // Open Boxes
    await Hive.openBox<TodoItem>('todos');
    await Hive.openBox<DungeonSave>('dungeon_save');
    await Hive.openBox<Player>('player');
  }
}