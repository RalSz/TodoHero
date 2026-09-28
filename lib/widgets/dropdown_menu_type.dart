import 'dart:collection';
import 'package:flutter/material.dart';

import '../quests/models/todo_item.dart';

class DropdownMenuType extends StatefulWidget {
  final ValueChanged<QuestType?> onChanged;
  const DropdownMenuType({
    super.key,
    required this.onChanged,
  });

  @override
  State<DropdownMenuType> createState() => _DropDownMenuTypeState();
}

class _DropDownMenuTypeState extends State<DropdownMenuType> {
  List<DropdownMenuEntry<QuestType>> menuEntries = UnmodifiableListView<DropdownMenuEntry<QuestType>>(
    QuestType.values.map(
      (QuestType val) => DropdownMenuEntry(value: val, label: TodoItem.typeNames[val.index])
    )
  );
  QuestType? _selected;

  @override
  void initState() {
    super.initState();

    _selected = menuEntries.first.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<QuestType>(
      initialSelection: _selected,
      dropdownMenuEntries: menuEntries,
      onSelected: (value) {
        widget.onChanged(value);
      },
    );
  }
}