import 'dart:convert';

import 'package:serializer_libs_comparison/utils/custom_stopwatch.dart';

import 'package:hive/hive.dart';
import 'package:hive/src/binary/binary_writer_impl.dart';
import 'package:hive/src/binary/binary_reader_impl.dart';

import '../data.dart';
import 'package:serializer_libs_comparison/models/index.dart';

void measureHive() async {
  ///
  /// Serializing
  ///
  final encode = Utf8Encoder();
  final decode = Utf8Decoder();

  final s = CustomStopWatch('\nHive serializing Character\n')..start();
  final writer = BinaryWriterImpl(Hive);

  writer
    ..writeByte(character.name.length)
    ..writeString(character.name, writeByteCount: false)
    ..writeByte(character.house.length)
    ..writeString(character.house, writeByteCount: false)
    ..write(character.playedBy)
    ..writeByte(character.age)
    ..writeByte(character.firstSeen.length)
    ..writeString(character.firstSeen, writeByteCount: false);

  final bytes = writer.toBytes();
  s..stop();

  TIME_RECORDER.add(Tracking(
      library: 'Hive', bytes: bytes.length, type: Types.encode, watch: s));

  ///
  /// Deserializing
  ///

  final s2 = CustomStopWatch('Hive deserialized Character\n')..start();
  final reader = BinaryReaderImpl(bytes, Hive);

  final char = Character()
    ..name = reader.readString(reader.readByte())
    ..house = reader.readString(reader.readByte())
    ..playedBy = reader.read() as Actor
    ..age = reader.readByte()
    ..firstSeen = reader.readString(reader.readByte());

  s2..stop();

  TIME_RECORDER.add(Tracking(
      library: 'Hive', bytes: bytes.length, type: Types.decode, watch: s2));
  // print(char);
}
