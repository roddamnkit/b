import 'package:b/b.dart';
import 'package:test/test.dart';

void main() {
  validationTests();
  converterTests();
}

void validationTests() {
  test('alphabet has duplicate characters 1', () {
    expect(
      () => BaseConversion(from: hexadecimal, to: '0123453789'),
      throwsA(allOf(
        isArgumentError,
        predicate(
          (ArgumentError e) => e.name == 'alphabet',
          'argument is alphabet',
        ),
      )),
    );
  });

  test('alphabet has duplicate characters 2', () {
    expect(
      () => BaseConversion(from: '0123453789', to: binary),
      throwsA(allOf(
        isArgumentError,
        predicate(
          (ArgumentError e) => e.name == 'alphabet',
          'argument is alphabet',
        ),
      )),
    );
  });
}

void converterTests() {
  test('invalid input', () {
    final BaseConversion b = BaseConversion(from: decimal, to: binary);
    expect(
      () => b('123abc'),
      throwsA(allOf(
        isArgumentError,
        predicate(
          (ArgumentError e) => e.name == 'x',
          'argument is x',
        ),
      )),
    );
  });

  {
    final Map<String, dynamic> converter = <String, dynamic>{
      'instance': BaseConversion(
        from: decimal,
        to: binary,
      ),
      'testCases': <Map<String, String>>[
        <String, String>{'from': '0', 'to': '0'},
        <String, String>{'from': '1', 'to': '1'},
        <String, String>{'from': '2', 'to': '10'},
        <String, String>{'from': '3', 'to': '11'},
        <String, String>{'from': '4', 'to': '100'},
        <String, String>{'from': '5', 'to': '101'},
        <String, String>{'from': '6', 'to': '110'},
        <String, String>{'from': '7', 'to': '111'},
        <String, String>{'from': '8', 'to': '1000'},
        <String, String>{'from': '9', 'to': '1001'},
        <String, String>{'from': '10', 'to': '1010'},
      ],
    };
    testConverter(converter);
  }
  {
    final Map<String, dynamic> converter = <String, dynamic>{
      'instance': BaseConversion(
        from: decimal,
        to: binary,
        zeroPadding: true,
      ),
      'testCases': <Map<String, String>>[
        <String, String>{'from': '0', 'to': '0000'},
        <String, String>{'from': '1', 'to': '0001'},
        <String, String>{'from': '2', 'to': '0010'},
        <String, String>{'from': '3', 'to': '0011'},
        <String, String>{'from': '4', 'to': '0100'},
        <String, String>{'from': '5', 'to': '0101'},
        <String, String>{'from': '6', 'to': '0110'},
        <String, String>{'from': '7', 'to': '0111'},
        <String, String>{'from': '8', 'to': '1000'},
        <String, String>{'from': '9', 'to': '1001'},
        <String, String>{'from': '10', 'to': '0001010'},
      ],
    };
    testConverter(converter);
  }
  {
    final Map<String, dynamic> converter = <String, dynamic>{
      'instance': BaseConversion(
        from: decimal,
        to: binary,
        zeroPadding: true,
      ).inverse(),
      'testCases': <Map<String, String>>[
        <String, String>{'to': '00', 'from': '0000'},
        <String, String>{'to': '01', 'from': '0001'},
        <String, String>{'to': '02', 'from': '0010'},
        <String, String>{'to': '03', 'from': '0011'},
        <String, String>{'to': '04', 'from': '0100'},
        <String, String>{'to': '05', 'from': '0101'},
        <String, String>{'to': '06', 'from': '0110'},
        <String, String>{'to': '07', 'from': '0111'},
        <String, String>{'to': '08', 'from': '1000'},
        <String, String>{'to': '09', 'from': '1001'},
        <String, String>{'to': '010', 'from': '0001010'},
      ],
    };
    testConverter(converter);
  }
  {
    final Map<String, dynamic> converter = <String, dynamic>{
      'instance': BaseConversion.alphabet(
        from: Alphabet(
          decimal,
          radixPoint: '.',
          repetendSymbols: '()',
        ),
        to: Alphabet(
          '0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣',
          radixPoint: '*️⃣',
          repetendSymbols: '#️⃣',
        ),
      ),
      'testCases': <Map<String, String>>[
        <String, String>{'from': '0', 'to': '0️⃣'},
        <String, String>{'from': '1', 'to': '1️⃣'},
        <String, String>{'from': '2', 'to': '2️⃣'},
        <String, String>{'from': '3', 'to': '3️⃣'},
        <String, String>{'from': '4', 'to': '4️⃣'},
        <String, String>{'from': '5', 'to': '5️⃣'},
        <String, String>{'from': '6', 'to': '6️⃣'},
        <String, String>{'from': '7', 'to': '7️⃣'},
        <String, String>{'from': '8', 'to': '8️⃣'},
        <String, String>{'from': '9', 'to': '9️⃣'},
        <String, String>{'from': '10', 'to': '1️⃣0️⃣'},
      ],
    };
    testConverter(converter);
  }
  {
    final Map<String, dynamic> converter = <String, dynamic>{
      'instance': BaseConversion.alphabet(
        from: Alphabet(
          decimal,
          radixPoint: '.',
          repetendSymbols: '()',
        ),
        to: Alphabet(
          '0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣',
          radixPoint: '*️⃣',
          repetendSymbols: '#️⃣',
        ),
        zeroPadding: true,
      ),
      'testCases': <Map<String, String>>[
        <String, String>{'from': '0', 'to': '0️⃣'},
        <String, String>{'from': '1', 'to': '1️⃣'},
        <String, String>{'from': '2', 'to': '2️⃣'},
        <String, String>{'from': '3', 'to': '3️⃣'},
        <String, String>{'from': '4', 'to': '4️⃣'},
        <String, String>{'from': '5', 'to': '5️⃣'},
        <String, String>{'from': '6', 'to': '6️⃣'},
        <String, String>{'from': '7', 'to': '7️⃣'},
        <String, String>{'from': '8', 'to': '8️⃣'},
        <String, String>{'from': '9', 'to': '9️⃣'},
        <String, String>{'from': '10', 'to': '1️⃣0️⃣'},
      ],
    };
    testConverter(converter);
  }
  {
    final Map<String, dynamic> converter = <String, dynamic>{
      'instance': BaseConversion.alphabet(
        from: Alphabet(
          hexadecimal,
          radixPoint: '.',
          repetendSymbols: '()',
        ),
        to: Alphabet(
          '0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣',
          radixPoint: '*️⃣',
          repetendSymbols: '#️⃣',
        ),
        zeroPadding: true,
      ).inverse(),
      'testCases': <Map<String, String>>[
        <String, String>{'to': '0CAFE', 'from': '5️⃣1️⃣9️⃣6️⃣6️⃣'},
        <String, String>{
          'to': '0DEADC0DE',
          'from': '3️⃣7️⃣3️⃣5️⃣9️⃣2️⃣9️⃣0️⃣5️⃣4️⃣'
        },
      ],
    };
    testConverter(converter);
  }
  {
    final Map<String, dynamic> converter = <String, dynamic>{
      'instance': BaseConversion(
        from: hexadecimal,
        to: binary,
        zeroPadding: false,
      ),
      'testCases': <Map<String, String>>[
        <String, String>{'from': '80', 'to': '10000000'},
        <String, String>{'from': '91', 'to': '10010001'},
        <String, String>{'from': 'A2', 'to': '10100010'},
        <String, String>{'from': 'B3', 'to': '10110011'},
        <String, String>{'from': 'C4', 'to': '11000100'},
        <String, String>{'from': 'D5', 'to': '11010101'},
        <String, String>{'from': 'E6', 'to': '11100110'},
        <String, String>{'from': 'F7', 'to': '11110111'},
        <String, String>{'from': '08', 'to': '1000'},
        <String, String>{'from': '19', 'to': '11001'},
        <String, String>{'from': '2A', 'to': '101010'},
        <String, String>{'from': '3B', 'to': '111011'},
        <String, String>{'from': '4C', 'to': '1001100'},
        <String, String>{'from': '5D', 'to': '1011101'},
        <String, String>{'from': '6E', 'to': '1101110'},
        <String, String>{'from': '7F', 'to': '1111111'},
      ],
    };
    testConverter(converter);
  }
  {
    final Map<String, dynamic> converter = <String, dynamic>{
      'instance': BaseConversion(
        from: hexadecimal,
        to: binary,
        zeroPadding: false,
      ).inverse(),
      'testCases': <Map<String, String>>[
        <String, String>{'to': '80', 'from': '10000000'},
        <String, String>{'to': '91', 'from': '10010001'},
        <String, String>{'to': 'A2', 'from': '10100010'},
        <String, String>{'to': 'B3', 'from': '10110011'},
        <String, String>{'to': 'C4', 'from': '11000100'},
        <String, String>{'to': 'D5', 'from': '11010101'},
        <String, String>{'to': 'E6', 'from': '11100110'},
        <String, String>{'to': 'F7', 'from': '11110111'},
        <String, String>{'to': '8', 'from': '00001000'},
        <String, String>{'to': '19', 'from': '00011001'},
        <String, String>{'to': '2A', 'from': '00101010'},
        <String, String>{'to': '3B', 'from': '00111011'},
        <String, String>{'to': '4C', 'from': '01001100'},
        <String, String>{'to': '5D', 'from': '01011101'},
        <String, String>{'to': '6E', 'from': '01101110'},
        <String, String>{'to': '7F', 'from': '01111111'},
      ],
    };
    testConverter(converter);
  }
}

void testConverter(Map<String, dynamic> converter) {
  group('function', () {
    converter['testCases'].forEach((Map<String, String> testCase) {
      test('${testCase['from']} -> ${testCase['to']}', () {
        expect(converter['instance'](testCase['from']), equals(testCase['to']));
      });
    });
  });
}
