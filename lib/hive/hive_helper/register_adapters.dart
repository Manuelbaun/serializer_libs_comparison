import 'package:hive/hive.dart';
import 'package:serializer_libs_comparison/models/index.dart';

void registerAdapters() {
  Hive.registerAdapter(ActorAdapter());
  Hive.registerAdapter(CharacterAdapter());
}
