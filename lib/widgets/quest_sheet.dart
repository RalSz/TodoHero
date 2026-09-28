import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

import '../theme/app_theme.dart';
import '../quests/models/todo_item.dart';

class QuestSheet extends StatefulWidget {
  const QuestSheet({super.key});

  @override
  State<QuestSheet> createState() => _QuestSheetState();
}

class _QuestSheetState extends State<QuestSheet>{
  late Box<TodoItem> _quests;

  @override
  void initState() {
    super.initState();
    _quests = Hive.box<TodoItem>('todos');
    
    // TEMP SEEDER
    if (_quests.isEmpty) {
      _quests.addAll([
        TodoItem(content: 'Buy Milk', dateDue: DateTime.now(), isDone: false, type: QuestType.once),
        TodoItem(content: 'Walk dog', dateDue: DateTime.now(), isDone: true, type: QuestType.daily),
        TodoItem(content: 'Do that', dateDue: DateTime.now(), isDone: false, type: QuestType.once)
      ]);
    }
  }

  Map<String, List<TodoItem>> _groupByDate(List<TodoItem> todos) {
    final grouped = groupBy(
      todos,
      (TodoItem t) => DateFormat('yyyy-MM-dd').format(t.dateDue),
    );

    return grouped;
  }

  @override
  Widget build(BuildContext context){
    return DraggableScrollableSheet(
      initialChildSize: 0.40,
      minChildSize: 0.40,
      maxChildSize: 1.0,
      snap: true,
      snapSizes: [ 0.4, 1.0],
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(
              top: BorderSide(
              color: AppColors.secondary,
              width: 4.0,
              )
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Material(
              color: Colors.transparent,
              child: ValueListenableBuilder(
                valueListenable: _quests.listenable(),
                builder: (context, Box<TodoItem> box, _) {
                  final todos = box.values.toList();
                  final grouped = _groupByDate(todos);
                  final sortedDates = grouped.keys.toList()..sort();
              
                  final screen = <Widget>[
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Center(
                    child: Text("Quests", style: AppTextStyles.title),
                    ),
                    Center(
                      child: Text("Completed Today: ${doneTodayCount(todos)}", style: AppTextStyles.body),
                    ),
                    if (todos.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top:24),
                        child: Center(child: Text('No Quests yet!')),
                      ),
                    for (final dateKey in sortedDates) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 8),
                        child: Row(
                          children: [
                            Image.asset('../assets/icons/Icon_Stamp1-1.png',
                              width: AppTextStyles.subtitle.fontSize,
                              height: AppTextStyles.subtitle.fontSize,
                            ),
                            SizedBox(width: 8,),
                            Text(
                              DateFormat('EEEE, MMM d').format(DateTime.parse(dateKey)),
                              style: AppTextStyles.subtitle,
                            ),
                          ],
                        ),
                      ),
                      ...grouped[dateKey]!.map((todo) => _TodoTile(todo: todo)),
                    ]
                  ];
              
                  return ListView(
                    controller: scrollController,
                    children: screen,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TodoTile extends StatelessWidget {
  final TodoItem todo;
  const _TodoTile({required this.todo});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: todo.isDone,
      onChanged: (bool? val) {
        todo.isDone = val ?? false;
        todo.dateDone = todo.isDone ? DateTime.now() : null;
        todo.save();
      },
      title: Text(
        todo.content,
        style: todo.isDone ? AppTextStyles.bodyLined : AppTextStyles.body,
      ),
      subtitle: Text(
        todo.typeAsString,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      ),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}

int doneTodayCount(List<TodoItem> todos) {
  final now = DateTime.now();
  return todos.where((t) {
    if (!t.isDone || t.dateDone == null) return false;
    final completed = t.dateDone!;
    return completed.year == now.year &&
      completed.month == now.month &&
      completed.day == now.day;
  }).length;
}