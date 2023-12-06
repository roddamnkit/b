import 'package:b/b.dart';
import 'package:benchmark_harness/benchmark_harness.dart';

void main() {
  ASCIIConverterBenchmark().report();

  NonASCIIConverterBenchmark().report();

  IntegerLengthFactorConverterBenchmark1().report();
  IntegerLengthFactorConverterBenchmark2().report();
  IntegerLengthFactorConverterBenchmark3().report();

  NonIntegerLengthFactorConverterBenchmark1().report();
  NonIntegerLengthFactorConverterBenchmark2().report();
  NonIntegerLengthFactorConverterBenchmark3().report();
  NonIntegerLengthFactorConverterBenchmark4().report();
}

class CustomBenchmarkBase extends BenchmarkBase {
  const CustomBenchmarkBase(String name) : super(name);

  @override
  void report() {
    for (int i = 0; i < 4; i++) {
      super.report();
    }
  }
}

class ASCIIConverterBenchmark extends CustomBenchmarkBase {
  ASCIIConverterBenchmark() : super('ASCIIConverter');

  late BaseConversion b;

  late String s;

  @override
  void run() {
    // 1326 ns/op
    b(s);
  }

  @override
  void setup() {
    b = BaseConversion(from: '0123456789', to: hexadecimal);

    s = '33204';
  }
}

class NonASCIIConverterBenchmark extends CustomBenchmarkBase {
  NonASCIIConverterBenchmark() : super('NonASCIIConverter');

  late BaseConversion b;

  late String s;

  @override
  void run() {
    // 1674 ns/op
    b(s);
  }

  @override
  void setup() {
    b = BaseConversion(from: '౦123456789', to: hexadecimal);

    s = '332౦4';
  }
}

class IntegerLengthFactorConverterBenchmark1 extends CustomBenchmarkBase {
  IntegerLengthFactorConverterBenchmark1()
      : super('IntegerLengthFactorConverter: Base64 -> Base8');

  late BaseConversion b;

  late String s;

  @override
  void run() {
    // 2609 ns/op
    b(s);
  }

  @override
  void setup() {
    b = BaseConversion(from: base64, to: base8);

    s = '33204';
  }
}

class IntegerLengthFactorConverterBenchmark2 extends CustomBenchmarkBase {
  IntegerLengthFactorConverterBenchmark2()
      : super('IntegerLengthFactorConverter: Base10 -> Base10 (reverted)');

  late BaseConversion b;

  late String s;

  @override
  void run() {
    // 922 ns/op
    b(s);
  }

  @override
  void setup() {
    b = BaseConversion(from: base10, to: '9876543210');

    s = '33204';
  }
}

class IntegerLengthFactorConverterBenchmark3 extends CustomBenchmarkBase {
  IntegerLengthFactorConverterBenchmark3()
      : super('IntegerLengthFactorConverter: Base6 -> Base36');

  late BaseConversion b;

  late String s;

  @override
  void run() {
    // 1189 ns/op
    b(s);
  }

  @override
  void setup() {
    b = BaseConversion(from: base6, to: base36);

    s = '33204';
  }
}

class NonIntegerLengthFactorConverterBenchmark1 extends CustomBenchmarkBase {
  NonIntegerLengthFactorConverterBenchmark1()
      : super('NonIntegerLengthFactorConverter: Base64 -> Base6');

  late BaseConversion b;

  late String s;

  @override
  void run() {
    // 2978 ns/op
    b(s);
  }

  @override
  void setup() {
    b = BaseConversion(from: base64, to: base6);

    s = '33204';
  }
}

class NonIntegerLengthFactorConverterBenchmark2 extends CustomBenchmarkBase {
  NonIntegerLengthFactorConverterBenchmark2()
      : super('NonIntegerLengthFactorConverter: Base64 -> Base10');

  late BaseConversion b;

  late String s;

  @override
  void run() {
    // 2410 ns/op
    b(s);
  }

  @override
  void setup() {
    b = BaseConversion(from: base64, to: base10);

    s = '33204';
  }
}

class NonIntegerLengthFactorConverterBenchmark3 extends CustomBenchmarkBase {
  NonIntegerLengthFactorConverterBenchmark3()
      : super('NonIntegerLengthFactorConverter: Base5 -> Base36');

  late BaseConversion b;

  late String s;

  @override
  void run() {
    // 1188 ns/op
    b(s);
  }

  @override
  void setup() {
    b = BaseConversion(from: '01234', to: base36);

    s = '33204';
  }
}

class NonIntegerLengthFactorConverterBenchmark4 extends CustomBenchmarkBase {
  NonIntegerLengthFactorConverterBenchmark4()
      : super('NonIntegerLengthFactorConverter: Base7 -> Base36');

  late BaseConversion b;

  late String s;

  @override
  void run() {
    // 1181 ns/op
    b(s);
  }

  @override
  void setup() {
    b = BaseConversion(from: '0123456', to: base36);

    s = '33204';
  }
}
