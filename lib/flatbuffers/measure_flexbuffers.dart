import 'package:flat_buffers/flex_buffers.dart';
import 'package:serializer_libs_comparison/utils/custom_stopwatch.dart';

import '../data.dart';

void measureFlexbuffers() {
  _buildFromObject();
  _buildVector();
  _buildMap();
}

void _buildFromObject() {
  final s = CustomStopWatch('Flexbuffer')..start();

  final bytes = Builder.buildFromObject(TEST_DATA);

  s..stop();

  TIME_RECORDER.add(Tracking(
      library: 'FlexBuffers build from Object',
      bytes: bytes.lengthInBytes,
      type: Types.encode,
      watch: s));

  final s2 = CustomStopWatch('Flexbuffer')..start();

  final bytes2 = Reference.fromBuffer(bytes);

  // bytes2.mapKeyIterable.forEach(print);

  s2..stop();

  TIME_RECORDER.add(Tracking(
      library: 'FlexBuffers Reference Object',
      bytes: bytes.lengthInBytes,
      type: Types.decode,
      watch: s2));
}

void _buildVector() {
  final s = CustomStopWatch('Flexbuffer')..start();

  final build = Builder(size: 512);
  build
    ..startVector()
    ..addString(TEST_DATA['actor']['birthCity'])
    ..addInt(TEST_DATA['actor']['dateOfBirth'])
    ..addString(TEST_DATA['actor']['name'])
    ..addInt(TEST_DATA['age'])
    ..addString(TEST_DATA['firstSeen'])
    ..addString(TEST_DATA['house'])
    ..addString(TEST_DATA['name'])
    ..end();

  final bytes = build.finish();
  s..stop();

  TIME_RECORDER.add(Tracking(
      library: 'FlexBuffers build into Vector',
      bytes: bytes.length,
      type: Types.encode,
      watch: s));

  // final s2 = CustomStopWatch('Flexbuffer')..start();

  // final bytes2 = Reference.fromBuffer(bytes.buffer);

  // s2..stop();

  // TIME_RECORDER.add(Tracking(
  //     library: 'FlexBuffers build from Vector bytes',
  //     bytes: bytes.lengthInBytes,
  //     type: Types.decode,
  //     watch: s2));
}

void _buildMap() {
  final s = CustomStopWatch('Flexbuffer')..start();

  // final bb = Builder.buildFromObject(TEST_DATA);

  final build = Builder(size: 512);
  build
    ..startMap()
    ..addKey('1')
    ..addInt(TEST_DATA['age'])
    ..addKey('2')
    ..addString(TEST_DATA['firstSeen'])
    ..addKey('3')
    ..addString(TEST_DATA['house'])
    ..addKey('4')
    ..addString(TEST_DATA['name'])
    ..addKey('5')
    ..startMap()
    ..addKey('1')
    ..addString(TEST_DATA['actor']['birthCity'])
    ..addKey('2')
    ..addInt(TEST_DATA['actor']['dateOfBirth'])
    ..addKey('3')
    ..addString(TEST_DATA['actor']['name'])
    ..end()
    ..end();

  final bytes = build.finish();
  s..stop();

  TIME_RECORDER.add(Tracking(
      library: 'FlexBuffers build into Map',
      bytes: bytes.length,
      type: Types.encode,
      watch: s));

  // final s2 = CustomStopWatch('Flexbuffer')..start();

  // final bytes2 = Reference.fromBuffer(bytes.buffer);

  // s2..stop();

  // bytes2.mapKeyIterable.forEach(print);

  // TIME_RECORDER.add(Tracking(
  //     library: 'FlexBuffers build from Map bytes',
  //     bytes: bytes.lengthInBytes,
  //     type: Types.decode,
  //     watch: s2));
}
