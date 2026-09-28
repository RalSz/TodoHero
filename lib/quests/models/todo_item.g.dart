// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoItemAdapter extends TypeAdapter<TodoItem> {
  @override
  final int typeId = 0;

  @override
  TodoItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoItem(
      content: fields[0] as String,
      dateDue: fields[1] as DateTime,
      isDone: fields[2] as bool,
      type: fields[3] as QuestType,
      dateStart: fields[4] as DateTime?,
      dateDone: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, TodoItem obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.content)
      ..writeByte(1)
      ..write(obj.dateDue)
      ..writeByte(2)
      ..write(obj.isDone)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.dateStart)
      ..writeByte(5)
      ..write(obj.dateDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuestTypeAdapter extends TypeAdapter<QuestType> {
  @override
  final int typeId = 1;

  @override
  QuestType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return QuestType.once;
      case 1:
        return QuestType.periodic;
      case 2:
        return QuestType.daily;
      case 3:
        return QuestType.repeatWeek;
      case 4:
        return QuestType.repeatMonth;
      default:
        return QuestType.once;
    }
  }

  @override
  void write(BinaryWriter writer, QuestType obj) {
    switch (obj) {
      case QuestType.once:
        writer.writeByte(0);
        break;
      case QuestType.periodic:
        writer.writeByte(1);
        break;
      case QuestType.daily:
        writer.writeByte(2);
        break;
      case QuestType.repeatWeek:
        writer.writeByte(3);
        break;
      case QuestType.repeatMonth:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
