import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:serializer_libs_comparison/hive/hive_helper/fields/character_fields.dart';
import 'package:serializer_libs_comparison/hive/hive_helper/hive_adapters.dart';
import 'package:serializer_libs_comparison/hive/hive_helper/hive_types.dart';

import 'actor.model.dart';

part 'character.model.g.dart';

@HiveType(typeId: HiveTypes.character, adapterName: HiveAdapters.character)
class Character extends HiveObject {
  @HiveField(CharacterFields.name)
  String name;

  @HiveField(CharacterFields.house)
  String house;

  @HiveField(CharacterFields.playedBy)
  Actor playedBy;

  @HiveField(CharacterFields.age)
  int age;

  @HiveField(CharacterFields.firstSeen)
  String firstSeen;
  Character({
    this.name,
    this.house,
    this.playedBy,
    this.age,
    this.firstSeen,
  });

  Character copyWith({
    String name,
    String house,
    Actor playedBy,
    int age,
    String firstSeen,
  }) {
    return Character(
      name: name ?? this.name,
      house: house ?? this.house,
      playedBy: playedBy ?? this.playedBy,
      age: age ?? this.age,
      firstSeen: firstSeen ?? this.firstSeen,
    );
  }

  Map<int, dynamic> toMap() {
    return {
      0: name,
      1: house,
      2: playedBy?.toMap(),
      3: age,
      4: firstSeen,
    };
  }

  static Character fromMap(Map<int, dynamic> map) {
    if (map == null) return null;

    return Character(
      name: map[0],
      house: map[1],
      playedBy: Actor.fromMap((map[2] as Map).cast<int, dynamic>()),
      age: map[3],
      firstSeen: map[4],
    );
  }

  String toJson() => json.encode(toMap());

  static Character fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Character(name: $name, house: $house, playedBy: $playedBy, age: $age, firstSeen: $firstSeen)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Character &&
        o.name == name &&
        o.house == house &&
        o.playedBy == playedBy &&
        o.age == age &&
        o.firstSeen == firstSeen;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        house.hashCode ^
        playedBy.hashCode ^
        age.hashCode ^
        firstSeen.hashCode;
  }
}
