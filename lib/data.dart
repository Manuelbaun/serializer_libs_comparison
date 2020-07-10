import 'package:serializer_libs_comparison/utils/custom_stopwatch.dart';

import 'models/index.dart';

const TEST_DATA = <String, dynamic>{
  'age': 40,
  'firstSeen': 'ep1',
  'house': 'Lannister',
  'name': 'Tyrion',
  'actor': {
    'birthCity': 'Morristown',
    'dateOfBirth': -17625600000, //DateTime(1969, 6, 11).millisecondsSinceEpoch
    'name': 'Peter Dinklage',
  },
};

enum Types { encode, decode }

class Tracking {
  String library;
  Types type;
  int bytes;
  CustomStopWatch watch;

  Tracking({
    this.library,
    this.watch,
    this.type,
    this.bytes,
  });

  String get ticks => watch.elapsedTicks.toString().padLeft(20);
  String get lib => library.padRight(30);
  String get types => type.toString().padLeft(15);
  String get byteLength => bytes.toString().padLeft(10);

  @override
  String toString() {
    return '$lib; $types; $byteLength bytes $ticks ticks';
  }
}

final TIME_RECORDER = <Tracking>[];

final actor = Actor()
  ..name = TEST_DATA['actor']['name']
  ..birthCity = TEST_DATA['actor']['birthCity']
  ..dateOfBirth = TEST_DATA['actor']['dateOfBirth'];

final character = Character()
  ..age = TEST_DATA['age']
  ..name = TEST_DATA['name']
  ..house = TEST_DATA['house']
  ..firstSeen = TEST_DATA['firstSeen']
  ..playedBy = actor;
