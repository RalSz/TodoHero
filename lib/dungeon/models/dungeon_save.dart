import 'package:hive/hive.dart';

import '../models/room_state.dart';

part 'dungeon_save.g.dart';

@HiveType(typeId: 11)
class DungeonSave extends HiveObject {
  @HiveField(0)
  int seed;

  @HiveField(1)
  int roomCount;

  @HiveField(2)
  int currentRoomId;

  @HiveField(3)
  Map<int, RoomState> roomStates;

  @HiveField(4)
  int currentTurn;

  DungeonSave({
    required this.seed,
    required this.roomCount,
    required this.currentRoomId,
    Map<int, RoomState>? roomStates,
    this.currentTurn = 0,
  }) : roomStates = roomStates ?? {};
}