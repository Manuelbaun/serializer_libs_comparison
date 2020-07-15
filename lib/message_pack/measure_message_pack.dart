import 'dart:typed_data';
import 'package:msgpack_dart/msgpack_dart.dart';
import 'package:serializer_libs_comparison/models/index.dart';
import 'package:serializer_libs_comparison/utils/custom_stopwatch.dart';

import '../data.dart';

class CustomEncoder extends ExtEncoder {
  @override
  Uint8List encodeObject(object) {
    if (object is Actor) return serialize(object.toMap());
    if (object is Character) return serialize(object.toMap());

    throw UnsupportedError('The type ${object.runtimeType} is not supported');
  }

  @override
  int extTypeForObject(object) {
    if (object is Actor) return 1;
    if (object is Character) return 2;

    throw UnsupportedError('The type ${object.runtimeType} is not registered');
  }
}

class CustomDecoder extends ExtDecoder {
  @override
  dynamic decodeObject(int extType, Uint8List data) {
    if (extType == 1) {
      final map = (deserialize(data) as Map).cast<String, dynamic>();
      return Actor.fromMap(map);
    }
    if (extType == 2) {
      final map = (deserialize(data) as Map).cast<String, dynamic>();
      return Character.fromMap(map);
    }

    throw UnsupportedError('The type ${extType} is not supported');
  }
}

final encoder = CustomEncoder();
final decoder = CustomDecoder();

void measureMessagePack() {
  _measureSeralizeViaToMapFunction();
  _measureJustObjectWithoutKeys();
}

void _measureSeralizeViaToMapFunction() {
  final s = CustomStopWatch('\nMessage Pack serialize\n')..start();
  final bytes = serialize(character, extEncoder: encoder);
  s..stop();

  TIME_RECORDER.add(Tracking(
      library: 'Message Pack with toMap Json',
      bytes: bytes.length,
      type: Types.encode,
      watch: s));

  ///
  /// Deserializing
  ///
  ///
  final s2 = CustomStopWatch('Message Pack deserialize\n')..start();
  final char = deserialize(bytes, extDecoder: decoder);
  s2..stop();
  // print(char);

  TIME_RECORDER.add(Tracking(
      library: 'Message Pack with fromMap Json',
      bytes: bytes.length,
      type: Types.decode,
      watch: s2));
}

void _measureJustObjectWithoutKeys() {
  final s = CustomStopWatch('\nMessage Pack serialize\n')..start();
  final bytes = serialize(TEST_DATA_NO_KEYS, extEncoder: encoder);
  s..stop();

  TIME_RECORDER.add(Tracking(
      library: 'Message Pack map, int keys',
      bytes: bytes.length,
      type: Types.encode,
      watch: s));

  final s2 = CustomStopWatch('Message Pack deserialize\n')..start();
  final char =
      (deserialize(bytes, extDecoder: decoder) as Map).cast<int, dynamic>();
  s2..stop();
  // print(char);

  TIME_RECORDER.add(Tracking(
      library: 'Message Pack map, int keys',
      bytes: bytes.length,
      type: Types.decode,
      watch: s2));
}
