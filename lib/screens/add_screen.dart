import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../theme/app_theme.dart';
import '../widgets/dropdown_menu_type.dart';
import '../widgets/date_picker.dart';
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

  final _taskController = TextEditingController();
  QuestType? _selectedType;
  DateTime? _selectedDate;

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
              onChanged: (value) => _selectedType = value,
            ),
            Text("Deadline", style: AppTextStyles.subtitle,),
            DatePicker(
              onChanged: (value) => _selectedDate = value,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final content = _taskController.text;
                  final type = _selectedType ?? QuestType.once;
                  final dateDue = _selectedDate!;
                  
                  final quest = TodoItem(content: content, type: type, dateDue: dateDue);
              
                  _quests.add(quest);
              
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