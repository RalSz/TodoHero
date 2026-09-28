enum RoomType {entrance, enemy, repair, boss}

class RoomNode {
  final int id;
  final RoomType type;
  final List<int> connections;

  RoomNode({
    required this.id,
    required this.type,
    required this.connections,
  });
}