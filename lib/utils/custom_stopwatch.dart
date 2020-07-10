class CustomStopWatch extends Stopwatch {
  final String name;
  CustomStopWatch([String name])
      : name = name ?? 'StopWatch',
        super();

  @override
  String toString() => '$elapsedTicks ticks';
}
