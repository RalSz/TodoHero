import 'package:flutter/material.dart';

import '../dungeon/models/dungeon_layout.dart';
import '../dungeon/models/dungeon_save.dart';
import '../dungeon/models/room_node.dart';
import '../dungeon/visualizer/dungeon_coordinates.dart';
import '../dungeon/visualizer/line_painter.dart';

class MapView extends StatelessWidget {
  final DungeonLayout layout;
  final DungeonSave save;
  final void Function(int roomId)? onRoomTap;
 
  const MapView({
    super.key,
    required this.layout,
    required this.save,
    this.onRoomTap,
  });
 
  Color _colorFor(RoomType type) {
    switch (type) {
      case RoomType.entrance:
        return Colors.green;
      case RoomType.boss:
        return Colors.redAccent;
      case RoomType.repair:
        return Colors.amber;
      case RoomType.enemy:
        return Colors.deepOrangeAccent;
    }
  }
 
  @override
  Widget build(BuildContext context) {
    final treeLayout = DungeonCoordinates.compute(layout);
 
    return InteractiveViewer(
      minScale: 0.5,
      maxScale: 2.5,
      constrained: false,
      boundaryMargin: const EdgeInsets.all(80),
      child: SizedBox(
        width: treeLayout.size.width,
        height: treeLayout.size.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(painter: LinePainter(treeLayout)),
            ),
            for (final node in layout.nodes.values)
              _buildRoomNode(node, treeLayout.positions[node.id]!),
          ],
        ),
      ),
    );
  }
 
  Widget _buildRoomNode(RoomNode node, Offset position) {
    final explored = save.roomStates[node.id]?.explored ?? false;
    final isCurrent = save.currentRoomId == node.id;
    const nodeSize = 40.0;
 
    return Positioned(
      left: position.dx - nodeSize / 2,
      top: position.dy - nodeSize / 2,
      child: GestureDetector(
        onTap: onRoomTap == null ? null : () => onRoomTap!(node.id),
        child: Container(
          width: nodeSize,
          height: nodeSize,
          decoration: BoxDecoration(
            //shape: BoxShape.circle,
            color: explored ? _colorFor(node.type) : Colors.grey.shade800,
            border: isCurrent ? Border.all(color: Colors.white, width: 3) : null,
          ),
          alignment: Alignment.center,
          child: explored
              ? Text(
                  '${node.id}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                )
              : const Icon(Icons.question_mark, color: Colors.white54, size: 16),
        ),
      ),
    );
  }
}