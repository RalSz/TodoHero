import 'package:flutter/material.dart';

import '../utils/scopes/dungeon_scope.dart';
import 'map_view.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dungeon = DungeonScope.of(context);

    if (!dungeon.isReady) 
    {
      return const Center(child: CircularProgressIndicator());
    }

    return MapView(
      layout: dungeon.layout!,
      save: dungeon.save!,
      onRoomTap: dungeon.visitRoom,
    );
  }
}