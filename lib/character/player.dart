import 'package:hive/hive.dart';

part 'player.g.dart'; //dart run build_runner build --delete-conflicting-outputs

@HiveType(typeId: 30)
class Player extends HiveObject 
{
  @HiveField(0)
  int completedQuestsToday;

  @HiveField(1)
  DateTime? lastActiveDate;

  @HiveField(2)
  int? completeRequirement;

  Player({
    required this.completedQuestsToday,
  });
}