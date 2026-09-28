import 'dart:ui';

import '../models/dungeon_layout.dart';

class DungeonCoordinates {
  final Map<int, Offset> positions;
  final Map<int, List<int>> childrenOf;
  final Size size;
 
  DungeonCoordinates({
    required this.positions,
    required this.childrenOf,
    required this.size,
  });
 
  factory DungeonCoordinates.compute(
    DungeonLayout layout, {
    double nodeSpacing = 70,
    double levelHeight = 100,
  }) {
    final childrenOf = <int, List<int>>{};
    final depthOf = <int, int>{layout.entranceId: 0};
    final visited = <int>{layout.entranceId};
 
    final queue = <int>[layout.entranceId];
    while (queue.isNotEmpty) {
      final id = queue.removeAt(0);
      final kids = layout.nodes[id]!.connections
          .where((n) => !visited.contains(n))
          .toList();
      childrenOf[id] = kids;
      for (final kid in kids) {
        visited.add(kid);
        depthOf[kid] = depthOf[id]! + 1;
        queue.add(kid);
      }
    }
 
    final xOf = <int, double>{};
    var nextSlot = 0.0;
 
    void assignX(int id) {
      final kids = childrenOf[id]!;
      if (kids.isEmpty) {
        xOf[id] = nextSlot++;
        return;
      }
      for (final kid in kids) {
        assignX(kid);
      }
      xOf[id] = (xOf[kids.first]! + xOf[kids.last]!) / 2;
    }
 
    assignX(layout.entranceId);
 
    final maxDepth = depthOf.values.reduce((a, b) => a > b ? a : b);
    final positions = {
      for (final id in layout.nodes.keys)
        id: Offset(
          xOf[id]! * nodeSpacing + nodeSpacing / 2,
          depthOf[id]! * levelHeight + levelHeight / 2,
        ),
    };
 
    return DungeonCoordinates(
      positions: positions,
      childrenOf: childrenOf,
      size: Size(
        nextSlot * nodeSpacing + nodeSpacing,
        (maxDepth + 1) * levelHeight + levelHeight,
      ),
    );
  }
}