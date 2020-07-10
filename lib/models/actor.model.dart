import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:serializer_libs_comparison/hive/hive_helper/fields/actor_fields.dart';
import 'package:serializer_libs_comparison/hive/hive_helper/hive_adapters.dart';
import 'package:serializer_libs_comparison/hive/hive_helper/hive_types.dart';

part 'actor.model.g.dart';

/// Note : Modified to and form Map. It is not json anymore!

@HiveType(typeId: HiveTypes.actor, adapterName: HiveAdapters.actor)
class Actor extends HiveObject {
  @HiveField(ActorFields.name)
  String name;

  @HiveField(ActorFields.dateOfBirth)
  int dateOfBirth;

  @HiveField(ActorFields.birthCity)
  String birthCity;
  Actor({
    this.name,
    this.dateOfBirth,
    this.birthCity,
  });

  Actor copyWith({
    String name,
    int dateOfBirth,
    String birthCity,
  }) {
    return Actor(
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      birthCity: birthCity ?? this.birthCity,
    );
  }

  Map<int, dynamic> toMap() {
    return {
      0: name,
      1: dateOfBirth,
      2: birthCity,
    };
  }

  static Actor fromMap(Map<int, dynamic> map) {
    if (map == null) return null;

    return Actor(
      name: map[0],
      dateOfBirth: map[1],
      birthCity: map[2],
    );
  }

  String toJson() => json.encode(toMap());

  static Actor fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'Actor(name: $name, dateOfBirth: $dateOfBirth, birthCity: $birthCity)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Actor &&
        o.name == name &&
        o.dateOfBirth == dateOfBirth &&
        o.birthCity == birthCity;
  }

  @override
  int get hashCode => name.hashCode ^ dateOfBirth.hashCode ^ birthCity.hashCode;
}
