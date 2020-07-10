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

  final s = CustomStopWatch('\nHive serializing Character\n')..start();
  final writer = BinaryWriterImpl(Hive);

  writer
    ..writeByte(5)
    ..writeByte(0)
    ..write(character.name)
    ..writeByte(1)
    ..write(character.house)
    ..writeByte(2)
    ..write(character.playedBy)
    ..writeByte(3)
    ..write(character.age)
    ..writeByte(4)
    ..write(character.firstSeen);

  final bytes = writer.toBytes();
  s..stop();

  TIME_RECORDER.add(Tracking(
      library: 'Hive', bytes: bytes.length, type: Types.encode, watch: s));

  ///
  /// Deserializing
  ///

  final s2 = CustomStopWatch('Hive deserialized Character\n')..start();

  final reader = BinaryReaderImpl(bytes, Hive);
  var numOfFields = reader.readByte();

  var fields = <int, dynamic>{
    for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
  };

  final char = Character()
    ..name = fields[0] as String
    ..house = fields[1] as String
    ..playedBy = fields[2] as Actor
    ..age = fields[3] as int
    ..firstSeen = fields[4] as String;

  s2..stop();

  TIME_RECORDER.add(Tracking(
      library: 'Hive', bytes: bytes.length, type: Types.decode, watch: s2));
  // print(char);
}
