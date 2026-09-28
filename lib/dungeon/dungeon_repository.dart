import 'package:hive_flutter/hive_flutter.dart';

import 'models/dungeon_save.dart';
import 'models/room_state.dart';
import '../dungeon/generation/dungeon_generator.dart';
import '../dungeon/models/dungeon_layout.dart';

class DungeonRepository {
  static const boxName = 'dungeon_save';
  static const _saveKey = 'current';

  Box<DungeonSave> get _box => Hive.box<DungeonSave>(boxName);

  Future<void> save(DungeonSave save) async {
    final box = _box;
    await box.put(_saveKey, save);
  }

  bool hasSave() {
    final box = _box;
    return box.containsKey(_saveKey);
  }

  (DungeonLayout, DungeonSave)? load() {
    final box = _box;
    final save = box.get(_saveKey);
    if (save == null) return null;

    final layout = DungeonGenerator(
      seed: save.seed,
      roomCount: save.roomCount
    ).generate();

    return(layout, save);
  }

  Future<DungeonSave> startNewRun({int? seed, int roomCount = 20}) async {
    final baseSeed = seed ?? (DateTime.now().millisecondsSinceEpoch & 0xFFFFFFFF);

    final layout = DungeonGenerator(seed: baseSeed, roomCount: roomCount).generate();

    final newSave = DungeonSave(
      seed: baseSeed,
      roomCount: roomCount,
      currentRoomId: layout.entranceId
    );

    await save(newSave);
    return newSave;
  }

  Future<void> deleteSave() async {
    final box = _box;
    await box.delete(_saveKey);
  }

  Future<void> visitRoom(DungeonSave save, int roomId, {int resetAfterTurns = 20,}) async {
    save.currentTurn++;

    final existing = save.roomStates[roomId];
    final isStale = existing != null && (save.currentTurn - existing.lastVisitedTurn) > resetAfterTurns;

    final state = (existing == null || isStale) ? RoomState() : existing;
    state
      ..explored = true
      ..lastVisitedTurn = save.currentTurn;
    
    save.roomStates[roomId] = state;
    save.currentRoomId = roomId;
    await save.save();
  }
}