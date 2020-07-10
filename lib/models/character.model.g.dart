// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterAdapter extends TypeAdapter<Character> {
  @override
  final typeId = 1;

  @override
  Character read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Character()
      ..name = fields[0] as String
      ..house = fields[1] as String
      ..playedBy = fields[2] as Actor
      ..age = fields[3] as int
      ..firstSeen = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.house)
      ..writeByte(2)
      ..write(obj.playedBy)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.firstSeen);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
