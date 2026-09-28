import 'package:flutter/material.dart';

import '../../dungeon/dungeon_manager.dart';

class DungeonScope extends InheritedNotifier<DungeonManager> {
  const DungeonScope({
    super.key,
    required DungeonManager manager,
    required super.child,
  }) : super(notifier: manager);
 
  static DungeonManager of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<DungeonScope>();
    assert(
      scope != null,
      'No DungeonScope found in context — wrap your tab shell in one.',
    );
    return scope!.notifier!;
  }
}