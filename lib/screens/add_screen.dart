import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../theme/app_theme.dart';
import '../widgets/dropdown_menu_type.dart';
import '../widgets/date_picker.dart';
import '../widgets/day_select_week.dart';
import '../widgets/day_select_month.dart';
import '../quests/models/todo_item.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  late Box<TodoItem> _quests;

  @override
  void initState() {
    super.initState();

    _quests = Hive.box<TodoItem>('todos');
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  final _taskController = TextEditingController();
  QuestType? _selectedType = QuestType.once;
  DateTime? _selectedEndDate;
  // MULTIPLE OCCURENCE TYPE TASK DATA
  int _selectedPeriod = 2;
  DateTime? _selectedStartDate;
  Set<String>? _selectedDaysWeek;
  Set<int>? _selectedDaysMonth;

  void _addQuestToBox()
  {
    final type = _selectedType ?? QuestType.once;
    final content = _taskController.text;

    final now = DateTime.now();
    final dateNow = DateTime(now.year, now.month, now.day);

    final start = _selectedStartDate ?? dateNow;
    final end = _selectedEndDate ?? dateNow;

    List<DateTime> days;
    String typeAsString;
    switch (type)
    {
      case QuestType.daily:
        days = _getDaysFromTypeAndRange(start, end, type);
        typeAsString = "Daily";
      case QuestType.periodic:
        days = _getDaysFromTypeAndRange(start, end, type, period: _selectedPeriod);
        typeAsString = "Every $_selectedPeriod days";
      case QuestType.repeatWeek:
        days = _getDaysFromTypeAndRange(start, end, type, daysW: _selectedDaysWeek);
        typeAsString = _getTypeAsString(type, daysW: _selectedDaysWeek);
      case QuestType.repeatMonth:
        days = _getDaysFromTypeAndRange(start, end, type, daysM: _selectedDaysMonth);
        typeAsString = _getTypeAsString(type, daysM: _selectedDaysMonth);
      default:
        days = [_selectedEndDate ?? dateNow];
        typeAsString = "One-Time";
    }
    for (DateTime day in days)
    {
      final quest = TodoItem(content: content, type: type, dateDue: day, typeAsString: typeAsString);
      _quests.add(quest);
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(  
        backgroundColor: AppColors.background,
        title: Text(
          "Create Quest",
          style: AppTextStyles.title,
        ),
        leading: Center(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: BackButton(
              color: AppColors.text,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Task", style: AppTextStyles.subtitle,),
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(width: 4))
              ),
            ),
            Text("Type", style: AppTextStyles.subtitle,),
            DropdownMenuType(
              onChanged: (value) => setState(() => _selectedType = value),
            ),
            // MULTIPLE OCCURENCE TYPE TASKS
            if (_selectedType != QuestType.once)
              ...[
                Text("Starting Date", style: AppTextStyles.subtitle,),
                DatePicker(
                  onChanged: (value) => setState(() => _selectedStartDate = value),
                ),
                if (_selectedType == QuestType.periodic)
                  ...[
                    Text("Every how many days?", style: AppTextStyles.subtitle,),
                    CupertinoPicker(
                      itemExtent: 40.0,
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          _selectedPeriod = index + 2;
                        });
                      },
                      children: List<Widget>.generate(364, (int index) {
                        return Center(
                          child: Text("${index + 2}", style: AppTextStyles.subtitle)
                        );
                      }),
                    ),
                  ]
                else if (_selectedType != QuestType.daily)
                  ...[
                    Text("Select days", style: AppTextStyles.subtitle,),
                    if (_selectedType == QuestType.repeatWeek)
                      DaySelectWeek(
                        onChanged: (value) => setState(() => _selectedDaysWeek = value)
                      )
                    else
                      DaySelectMonth(
                        onChanged: (value) => setState(() => _selectedDaysMonth = value)
                      )
                  ]
              ],
            Text("Deadline", style: AppTextStyles.subtitle,),
            DatePicker(
              onChanged: (value) => setState(() => _selectedEndDate = value),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _addQuestToBox();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(70,70),
                ),
                child: Text("Done", style: AppTextStyles.subtitle,)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<DateTime> _getDaysFromTypeAndRange(DateTime start, DateTime end, QuestType type, {int? period, Set<String>? daysW, Set<int>? daysM}) {
  int totalDays = end.difference(start).inDays;

  if (type == QuestType.daily) // DAILY
  {
    return List.generate(
      totalDays + 1,
      (index) => DateTime(start.year, start.month, start.day + index)
    );
  } else if (type == QuestType.periodic) // PERIODIC
  {
    List<DateTime> dates = [];
    var current = DateTime(start.year, start.month, start.day);
    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      dates.add(start.isUtc
        ? current 
        : DateTime(current.year, current.month, current.day)
      );
      
      current = current.add(Duration(days: period!));
    }
    return dates;
  } else if (type == QuestType.repeatWeek) {

    List<DateTime> dates = [];
    final targets = _turnStrDaysToInt(daysW!);
    var current = DateTime(start.year, start.month, start.day);    
    
    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      if (targets.contains(current.weekday)) {
      dates.add(start.isUtc 
        ? current 
        : DateTime(current.year, current.month, current.day)
      );
      }
      current = current.add(Duration(days: 1));
    }
    return dates;
  } else { // MONTH
    List<DateTime> dates = [];
    var current = DateTime.utc(start.year, start.month, start.day);

    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      if (daysM!.contains(current.day))
      {
        dates.add(start.isUtc 
          ? current 
          : DateTime(current.year, current.month, current.day)
        );
        
      }
      current = current.add(Duration(days: 1));
    }
    return dates;
  }
}

List<int> _turnStrDaysToInt(Set<String> days)
{
  final _indexes = ["M", "Tu", "W", "Th", "F", "Sa", "Su"];
  List<int> result = [];
  for (String day in days)
  {
    result.add(_indexes.indexOf(day) + 1);
  }
  return result;
}

String _getTypeAsString(QuestType type, {Set<String>? daysW, Set<int>? daysM}) {
  if (type == QuestType.repeatWeek) {
    return "Every ${daysW!.join(", ")}";
  } else { // MONTH
    List<int> list = daysM!.toList();
    list.sort();
    List<String> days = [];
    for (int day in list)
    {
      if (day % 10 == 1 || day != 11)
      {
        days.add("${day}st");
      } else if (day % 10 == 2 || day != 12)
      {
        days.add("${day}nd");
      } else if (day % 10 == 3 || day != 13)
      {
        days.add("${day}rd");
      } else
      {
        days.add("${day}th");
      }
    }
    return "Every $days";
  }
}