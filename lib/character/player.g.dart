// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerAdapter extends TypeAdapter<Player> {
  @override
  final int typeId = 30;

  @override
  Player read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Player(
      completedQuestsToday: fields[0] as int,
    )
      ..lastActiveDate = fields[1] as DateTime?
      ..completeRequirement = fields[2] as int?;
  }

  @override
  void write(BinaryWriter writer, Player obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.completedQuestsToday)
      ..writeByte(1)
      ..write(obj.lastActiveDate)
      ..writeByte(2)
      ..write(obj.completeRequirement);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
