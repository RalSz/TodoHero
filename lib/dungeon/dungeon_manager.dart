import 'package:flutter/material.dart';
import '../dungeon/models/dungeon_layout.dart';
import '../dungeon/models/dungeon_save.dart';
import '../dungeon/models/room_node.dart';
import '../dungeon/models/room_state.dart';

import 'dungeon_repository.dart';

class DungeonManager extends ChangeNotifier{
  final DungeonRepository _repo;

  DungeonLayout? _layout;
  DungeonSave? _save;
  bool _loading = true;

  DungeonManager({DungeonRepository? repository})
    : _repo = repository ?? DungeonRepository();

  DungeonLayout? get layout => _layout;
  DungeonSave? get save => _save;
  bool get isReady => !_loading && _layout != null && _save != null;

  RoomNode? get currentRoom {
    final layout = _layout;
    final save = _save;
    if (layout == null || save == null) return null;
    return layout.nodes[save.currentRoomId];
  }

  RoomState? get currentRoomState {
    final room = currentRoom;
    if (_save == null || room == null) return null;
    return _save!.roomStates[room.id];
  }

  Future<void> load() async {
    try
    {
      var result = _repo.load();
      if (result == null) {
        await _repo.startNewRun();
        result = _repo.load();
      }
      _layout = result!.$1;
      _save = result.$2;
    } catch (e, stack)
    {
      debugPrint("DungeonManager.load fail: $e\n$stack");
    }
    finally
    {
      _loading = false;

      notifyListeners();
      debugPrint("DungeonManager.load finish");
    }
  }

  Future<void> visitRoom(int roomId) async {
    if (_save == null) return;
    await _repo.visitRoom(_save!, roomId);
    notifyListeners();
  }

  Future<void> updateCurrentRoomState(
    void Function(RoomState state) mutate,
  ) async {
    final save = _save;
    final room = currentRoom;
    if (save == null || room == null) return;
 
    final state = save.roomStates[room.id] ?? RoomState();
    mutate(state);
    save.roomStates[room.id] = state;
    await save.save();
    notifyListeners();
  }
}