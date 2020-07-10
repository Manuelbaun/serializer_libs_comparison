import 'package:hive/hive.dart';
import 'package:serializer_libs_comparison/data.dart';
import 'package:serializer_libs_comparison/flatbuffers/measure_flatbuffers.dart';
import 'package:serializer_libs_comparison/hive/hive_helper/register_adapters.dart';
import 'package:serializer_libs_comparison/hive/measure_hive.dart';
import 'package:serializer_libs_comparison/message_pack/measure_message_pack.dart';

void main(List<String> arguments) {
  Hive.init('./hive');

  registerAdapters();

  var run = 1000;
  for (var i = 0; i < run; i++) {
    measureHive();
    measureFlatbuffers();
    measureMessagePack();
  }

  final map = <String, int>{};

  TIME_RECORDER.forEach((t) {
    final key = t.lib + t.types + t.byteLength;
    final value = t.watch.elapsedTicks;
    map[key] ??= 0;
    map[key] += value;
  });

  print('\n\nRuns $run:\n');

  map.forEach((key, value) {
    final time = (value / run).toString().padLeft(10);
    print('$key bytes : $time average ticks');
  });
}
