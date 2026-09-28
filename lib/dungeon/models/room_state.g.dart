// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoomStateAdapter extends TypeAdapter<RoomState> {
  @override
  final int typeId = 10;

  @override
  RoomState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoomState(
      explored: fields[0] as bool,
      lastVisitedTurn: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RoomState obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.explored)
      ..writeByte(2)
      ..write(obj.lastVisitedTurn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoomStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
