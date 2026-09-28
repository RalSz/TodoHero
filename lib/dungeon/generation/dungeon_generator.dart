import 'seeded_random.dart';
import '../models/dungeon_layout.dart';
import '../models/room_node.dart';

class DungeonGenerator {
  final int seed;
  final int roomCount;
  final int maxBranches;

  DungeonGenerator({
    required this.seed,
    this.roomCount = 1826, // 5 Years if 1 Room = 1 Day
    this.maxBranches = 3,
  });

  DungeonLayout generate() {
    final rng = SeededRandom(seed);
    final connections = <int, List<int>>{};
 
    int nextId = 0;
    final entranceId = nextId++;
    connections[entranceId] = [];
 
    final frontier = <int>[entranceId];
    int? lastBranchParent; // most recent parent that got a sibling group
 
    while (connections.length < roomCount && frontier.isNotEmpty) {
      final remaining = roomCount - connections.length;
 
      if (remaining < 2) {
        
        if (remaining == 1 && lastBranchParent != null) {
          final childId = nextId++;
          connections[lastBranchParent]!.add(childId);
          connections[childId] = [lastBranchParent];
        }
        break;
      }
 
      final parentId = frontier.removeAt(rng.nextInt(frontier.length));
      final cap = remaining < maxBranches ? remaining : maxBranches;
      final branches = cap == 2 ? 2 : 2 + rng.nextInt(cap - 1); // always in [2, cap]
 
      for (var i = 0; i < branches; i++) {
        final childId = nextId++;
        connections[parentId]!.add(childId);
        connections[childId] = [parentId];
        frontier.add(childId);
      }
      lastBranchParent = parentId;
    }
 
    final ids = connections.keys.toList()..sort();
    final nodes = <int, RoomNode>{};
    
    for (final id in ids) {
      RoomType type;
      if (id == entranceId) {
        type = RoomType.entrance;
      } else if (id == ids.last) {
        type = RoomType.boss;
      } else if (rng.nextBool(0.15)) {
        type = RoomType.repair;
      } else {
        type = RoomType.enemy;
      }
    
      nodes[id] = RoomNode(id: id, type: type, connections: connections[id]!);
    }
 
    return DungeonLayout(seed: seed, entranceId: entranceId, nodes: nodes);
  }
}