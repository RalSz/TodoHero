import 'package:hive/hive.dart';

part 'todo_item.g.dart'; //dart run build_runner build --delete-conflicting-outputs

@HiveType(typeId: 01)
enum QuestType {
  @HiveField(0)
  once,
  @HiveField(1)
  periodic,
  @HiveField(2)
  daily,
  @HiveField(3)
  repeatWeek,
  @HiveField(4)
  repeatMonth
}

@HiveType(typeId: 00)
class TodoItem extends HiveObject {

  @HiveField(0)
  String content;

  @HiveField(1)
  DateTime dateDue;

  @HiveField(2)
  bool isDone;

  @HiveField(3)
  QuestType type;

  @HiveField(4)
  DateTime? dateStart;

  @HiveField(5)
  DateTime? dateDone;

  TodoItem({
    required this.content,
    required this.dateDue,
    required this.type,
    this.isDone = false,
    DateTime? dateStart,
    this.dateDone,
  }): dateStart = dateStart ?? DateTime.now() ;

  String get typeAsString {
    switch (type)
    {
      case QuestType.daily:
        return "Daily";
      case QuestType.periodic: 
        return "Every x days";
      case QuestType.repeatWeek:
        return "Every x"; 
      case QuestType.repeatMonth:
        return "Every xth day";
      default:
        return "One-Time";
    }
  }

  static const List<String> typeNames = ["Once", "Periodic", "Daily", "Repeat Weekly", "Repeat Monthly"];
}