# A serializer comparison of different libraries in Dart

1. Hive Serializer
2. Flatbuffers 
3. Message Pack
4. Isar  (TODO)

**Infos**
I used the VSCode extension **Dart Data Class Generator** to generate data classes and modified the `fromMap` and `toMap` methods a bit. I removed the keys of type string and replaced them with plain integers.

The Dart classes can be found under `lib/models` as well as the Hive generated adapters. The model generated by flatbuffers can be found under `lib/flatbuffers/models_models_generated.dart`.


The Model:
```
{
  'age': 40,
  'firstSeen': 'ep1',
  'house': 'Lannister',
  'name': 'Tyrion',
  'actor': {
    'birthCity': 'Morristown',
    'dateOfBirth': -17625600000, //DateTime(1969, 6, 11).millisecondsSinceEpoch
    'name': 'Peter Dinklage',
  },
}
```


I used `dart2native` to compile to machine code and run the test in a loop and to average them out. My CPU Intel i9-9900k:

**running compiled**
```
Runs 10:
Hive                             Types.encode        96 bytes :       45.1 average ticks
Hive                             Types.decode        96 bytes :       20.9 average ticks
Flatbuffers objectBuilder        Types.encode       160 bytes :       34.5 average ticks
Flatbuffers objectBuilder        Types.decode       160 bytes :        2.5 average ticks
Flatbuffers buffersBuilder       Types.encode       160 bytes :       31.5 average ticks
Flatbuffers buffersBuilder       Types.decode       160 bytes :        2.1 average ticks
Message Pack                     Types.encode        70 bytes :       70.2 average ticks
Message Pack                     Types.decode        70 bytes :       23.5 average ticks
```
----
```
Runs 100:
Hive                             Types.encode        96 bytes :      25.14 average ticks
Hive                             Types.decode        96 bytes :      16.83 average ticks
Flatbuffers objectBuilder        Types.encode       160 bytes :      29.88 average ticks
Flatbuffers objectBuilder        Types.decode       160 bytes :       2.01 average ticks
Flatbuffers buffersBuilder       Types.encode       160 bytes :      27.81 average ticks
Flatbuffers buffersBuilder       Types.decode       160 bytes :       1.84 average ticks
Message Pack                     Types.encode        70 bytes :       54.8 average ticks
Message Pack                     Types.decode        70 bytes :      19.57 average ticks
```
----
```
Runs 1000:
Hive                             Types.encode        96 bytes :     18.787 average ticks
Hive                             Types.decode        96 bytes :     23.846 average ticks
Flatbuffers objectBuilder        Types.encode       160 bytes :     23.287 average ticks
Flatbuffers objectBuilder        Types.decode       160 bytes :      1.354 average ticks
Flatbuffers buffersBuilder       Types.encode       160 bytes :     23.424 average ticks
Flatbuffers buffersBuilder       Types.decode       160 bytes :      1.325 average ticks
Message Pack                     Types.encode        70 bytes :     41.673 average ticks
Message Pack                     Types.decode        70 bytes :     14.372 average ticks
```

**running in vm**

```
Runs 10:

Hive                             Types.encode        96 bytes :     5232.0 average ticks
Hive                             Types.decode        96 bytes :     2203.1 average ticks
Flatbuffers objectBuilder        Types.encode       160 bytes :     3785.6 average ticks
Flatbuffers objectBuilder        Types.decode       160 bytes :      494.6 average ticks
Flatbuffers buffersBuilder       Types.encode       160 bytes :      858.4 average ticks
Flatbuffers buffersBuilder       Types.decode       160 bytes :       16.1 average ticks
Message Pack                     Types.encode        70 bytes :     3916.2 average ticks
Message Pack                     Types.decode        70 bytes :     2099.2 average ticks
```

```
Runs 100:

Hive                             Types.encode        96 bytes :     693.16 average ticks
Hive                             Types.decode        96 bytes :     441.76 average ticks
Flatbuffers objectBuilder        Types.encode       160 bytes :     672.85 average ticks
Flatbuffers objectBuilder        Types.decode       160 bytes :      67.45 average ticks
Flatbuffers buffersBuilder       Types.encode       160 bytes :     366.19 average ticks
Flatbuffers buffersBuilder       Types.decode       160 bytes :      13.96 average ticks
Message Pack                     Types.encode        70 bytes :      791.9 average ticks
Message Pack                     Types.decode        70 bytes :     443.23 average ticks
```

```
Runs 1000:

Hive                             Types.encode        96 bytes :    151.505 average ticks
Hive                             Types.decode        96 bytes :    118.854 average ticks
Flatbuffers objectBuilder        Types.encode       160 bytes :    162.797 average ticks
Flatbuffers objectBuilder        Types.decode       160 bytes :     20.825 average ticks
Flatbuffers buffersBuilder       Types.encode       160 bytes :    109.985 average ticks
Flatbuffers buffersBuilder       Types.decode       160 bytes :     10.055 average ticks
Message Pack                     Types.encode        70 bytes :    267.008 average ticks
Message Pack                     Types.decode        70 bytes :     126.68 average ticks
```


Thoughts:
* I am not 100% convinced, that those measurements reflects the real performance. 
* I only can say, that flatbuffers do take the most bytes. While debugging, flatbuffers had a lot of `0` bytes in the `ByteData` buffer. 
* Also, using flatbuffers `ObjectBuilder` took may more time, when running via the VM, then the `BuffersBuilder`. But when compiled the `ObjectBuilder` on average was faster.
* Obviously, they are some runtime optimizations, thats happening. The decode methods for flatbuffers bytes for the `ObjectBuilder` and the `BufferBuilder` is actually the exact same method. So by does it take longer, when decode a byte using `ObjectBuilder`?




### commands to compile flatbuffers
`.\flatc.exe --dart  -o .\lib\models -I .\idl .\idl\monster.fbs`

`.\flatc.exe --dart --gen-mutable --schema -b -o .\lib\models -I .\idl .\idl\models.fbs`
