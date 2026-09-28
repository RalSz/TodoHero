import 'package:hive/hive.dart';

part 'room_state.g.dart';

@HiveType(typeId: 10)
class RoomState extends HiveObject {
  @HiveField(0)
  bool explored;

  /*@HiveField(1)
  String type;*/
  
  @HiveField(2)
  int lastVisitedTurn;

  RoomState({
    this.explored = false,
    /*required this.type,*/
    this.lastVisitedTurn = 0,
  });
}