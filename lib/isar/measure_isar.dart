import 'dart:ffi';
import 'dart:typed_data';

import 'package:serializer_libs_comparison/models/index.dart';

import 'src/binary/binary_writer.dart';

/// Note, the non-nullable was removed, other wise it would not work
/// with the other tests here!

void measureIsar() {}

// void serialize(Character object) {
//   var dynamicSize = 0;
//   var nameBytes = BinaryWriter.utf8Encoder.convert(object.name);
//   var nameBytes = BinaryWriter.utf8Encoder.convert(object.name);

//   var bufferSize = 17 + dynamicSize;
//   // var ptr = allocate<Uint8>(count: bufferSize);
//   // var buffer = ptr.asTypedList(bufferSize);
//   var buffer = Uint8List(length);
//   var writer = BinaryWriter(buffer, 17);

//   writer.writeInt(object.age);
//   writer.writeBool(object.isCustomer);
//   writer.writeBytes(nameBytes);

//   raw.oid = object.id;
//   raw.data = ptr;
//   raw.length = bufferSize;
// }

// User deserialize(RawObject raw) {
//   var buffer = raw.data.asTypedList(raw.length);
//   var reader = BinaryReader(buffer);
//   var object = User();
//   object.age = reader.readIntOrNull();
//   object.isCustomer = reader.readBoolOrNull();
//   object.name = reader.readStringOrNull();
//   return object;
// }
