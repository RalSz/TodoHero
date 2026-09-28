// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dungeon_save.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DungeonSaveAdapter extends TypeAdapter<DungeonSave> {
  @override
  final int typeId = 11;

  @override
  DungeonSave read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DungeonSave(
      seed: fields[0] as int,
      roomCount: fields[1] as int,
      currentRoomId: fields[2] as int,
      roomStates: (fields[3] as Map?)?.cast<int, RoomState>(),
      currentTurn: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DungeonSave obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.seed)
      ..writeByte(1)
      ..write(obj.roomCount)
      ..writeByte(2)
      ..write(obj.currentRoomId)
      ..writeByte(3)
      ..write(obj.roomStates)
      ..writeByte(4)
      ..write(obj.currentTurn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DungeonSaveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
