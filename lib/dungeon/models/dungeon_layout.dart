import 'room_node.dart';

class DungeonLayout {
  final int seed;
  final int entranceId;
  final Map<int, RoomNode> nodes;

  DungeonLayout({
    required this.seed,
    required this.entranceId,
    required this.nodes,
  });
}