import 'package:flutter/material.dart';

import 'dungeon_coordinates.dart';

class LinePainter extends CustomPainter {
  final DungeonCoordinates treeCoords;
 
  LinePainter(this.treeCoords);
 
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 2;
 
    treeCoords.childrenOf.forEach((parentId, kids) {
      final from = treeCoords.positions[parentId]!;
      for (final kidId in kids) {
        final to = treeCoords.positions[kidId]!;
        canvas.drawLine(from, to, paint);
      }
    });
  }
 
  @override
  bool shouldRepaint(covariant LinePainter oldDelegate) =>
      oldDelegate.treeCoords != treeCoords;
}