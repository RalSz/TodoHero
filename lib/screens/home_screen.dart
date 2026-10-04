import 'package:flutter/material.dart';

import '../widgets/quest_sheet.dart';
import '../utils/scopes/dungeon_scope.dart';
import '../dungeon/dungeon_manager.dart';
import '../dungeon/models/room_node.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dungeon = DungeonScope.of(context);

    Widget _pickRoomContent()
    {
      if (!dungeon.isReady) 
      {
        return Center(child: CircularProgressIndicator());
      }
      final room = dungeon.currentRoom;
      if (room == null) {
        return const Center(child: Text('No current room.'));
      }
  
      return _buildRoomContent(context, room);
    }

    return Stack(
      children: [
        if (dungeon.currentRoomState?.cleared ?? false)
        ...[
          Center(
            child: Text("Room Cleared!", style: AppTextStyles.title,),
          )
        ],
        Positioned(
          left: 0,
          right: 0,
          height: MediaQuery.of(context).size.height * 0.55,
          child: Image.asset('assets/images/DungeonRoom1-4.png',
            fit: BoxFit.fitHeight,
            alignment: Alignment.topCenter,
          )
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.27,
          left: MediaQuery.of(context).size.width * 0.1,
          child: Image.asset('assets/images/Knight-Test.png',
            height: MediaQuery.of(context).size.height * 0.25,
            fit: BoxFit.contain,
          ),
        ),
        _pickRoomContent(),
        QuestSheet(
          onActionComplete: () => _performAction(dungeon),
        ),
      ],
    );
  }
}

Widget _buildRoomContent(BuildContext context, RoomNode room) {
  switch (room.type) {
    case RoomType.entrance:
      return Positioned(
        top: MediaQuery.of(context).size.height * 0.32,
        /*right: MediaQuery.of(context).size.width * 0.1,*/
        right: 0,                                           // TEMP WHILE PLACEHOLDER
        child: Image.asset('assets/images/Entrance_test.png',
          height: MediaQuery.of(context).size.height * 0.20,
          fit: BoxFit.contain,
        ),
      );

    case RoomType.boss:
      return Positioned(
        top: MediaQuery.of(context).size.height * 0.23,
        /*right: MediaQuery.of(context).size.width * 0.1,*/
        right: 0,                                           // TEMP WHILE PLACEHOLDER
        child: Image.asset('assets/images/Boss_test.png',
          height: MediaQuery.of(context).size.height * 0.3,
          fit: BoxFit.contain,
        ),
      );

    case RoomType.repair:
      return Positioned(
        top: MediaQuery.of(context).size.height * 0.395,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Image.asset('assets/images/Repair.png',
          height: MediaQuery.of(context).size.height * 0.125,
          fit: BoxFit.contain,
        ),
      );

    case RoomType.enemy:
      return Positioned(
        top: MediaQuery.of(context).size.height * 0.29,
        /*right: MediaQuery.of(context).size.width * 0.1,*/
        right: 0,                                           // TEMP WHILE PLACEHOLDER
        child: Image.asset('assets/images/Enemy_test.png',
          height: MediaQuery.of(context).size.height * 0.25,
          fit: BoxFit.contain,
        ),
      );
  }
}

// PERFORM ACTION
void _performAction(DungeonManager dungeon)
{
  dungeon.updateCurrentRoomState((state) {
    state.cleared = true;
  });
}