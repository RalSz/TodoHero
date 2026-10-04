import 'package:hive/hive.dart';

part 'room_state.g.dart';

@HiveType(typeId: 10)
class RoomState extends HiveObject {
  @HiveField(0)
  bool explored;

  @HiveField(1)
  bool cleared;
  
  @HiveField(2)
  int lastVisitedTurn;

  RoomState({
    this.explored = false,
    this.cleared = false,
    this.lastVisitedTurn = 0,
  });
}