import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart';

import '../data.dart';
import '../utils/custom_stopwatch.dart';
import 'models_models_generated.dart';

void measureFlatbuffers() {
  _objectBuilder();
  _buffersBuilder();
}

void _objectBuilder() {
  final actor = ActorObjectBuilder(
    birthCity: TEST_DATA['actor']['birthCity'],
    dateOfBirth: TEST_DATA['actor']['dateOfBirth'],
    name: TEST_DATA['actor']['name'],
  );

  final obj = CharacterObjectBuilder(
    age: TEST_DATA['age'],
    firstSeen: TEST_DATA['firstSeen'],
    house: TEST_DATA['house'],
    name: TEST_DATA['name'],
    playedBy: actor,
  );

  ///
  /// Serializing
  ///

  final s =
      CustomStopWatch('\nFlatbuffers: objectBuilder serializing Character\n')
        ..start();
  final bytes = obj.toBytes();
  s..stop();

  TIME_RECORDER.add(Tracking(
      library: 'Flatbuffers objectBuilder',
      bytes: bytes.length,
      type: Types.encode,
      watch: s));

  ///
  /// Deserializing
  ///

  final s1 = _deserialize(bytes);

  TIME_RECORDER.add(Tracking(
      library: 'Flatbuffers objectBuilder',
      bytes: bytes.length,
      type: Types.decode,
      watch: s1));
}

///
/// This is the recommendet way of serializing via flat buffers...
void _buffersBuilder() {
  final s =
      CustomStopWatch('\nFlatbuffers: buffersBuilder serializing Character\n')
        ..start();

  final builder = Builder(initialSize: 256);

  ///
  /// Serializing
  ///

  // first create Actor
  final off1 = builder.writeString(TEST_DATA['actor']['name']);
  final off2 = builder.writeString(TEST_DATA['actor']['birthCity']);
  final dateOfBirth = TEST_DATA['actor']['dateOfBirth'];

  final actorBuilder = ActorBuilder(builder)
    ..begin()
    ..addNameOffset(off1)
    ..addBirthCityOffset(off2)
    ..addDateOfBirth(dateOfBirth);

  final int actorOffset = actorBuilder.finish();

  final off3 = builder.writeString(TEST_DATA['firstSeen']);
  final off4 = builder.writeString(TEST_DATA['house']);
  final off5 = builder.writeString(TEST_DATA['name']);
  final age = TEST_DATA['age'];

  final charBuilder = CharacterBuilder(builder)
    ..begin()
    ..addAge(age)
    ..addFirstSeenOffset(off3)
    ..addHouseOffset(off4)
    ..addNameOffset(off5)
    ..addPlayedByOffset(actorOffset);

  final charOffset = charBuilder.finish();

  final bytes = builder.finish(charOffset);
  s..stop();

  TIME_RECORDER.add(Tracking(
      library: 'Flatbuffers buffersBuilder',
      bytes: bytes.length,
      type: Types.encode,
      watch: s));

  final s1 = _deserialize(bytes);

  TIME_RECORDER.add(Tracking(
      library: 'Flatbuffers buffersBuilder',
      bytes: bytes.length,
      type: Types.decode,
      watch: s1));
}

CustomStopWatch _deserialize(Uint8List bytes) {
  final s = CustomStopWatch('Flatbuffers deserialized Character\n')..start();
  final char = Character(bytes);
  s..stop();
  // print(char);
  return s;
}
