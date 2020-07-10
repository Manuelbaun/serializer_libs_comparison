// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActorAdapter extends TypeAdapter<Actor> {
  @override
  final typeId = 0;

  @override
  Actor read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Actor()
      ..name = fields[0] as String
      ..dateOfBirth = fields[1] as int
      ..birthCity = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, Actor obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.dateOfBirth)
      ..writeByte(2)
      ..write(obj.birthCity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
