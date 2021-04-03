import 'package:b/b.dart';
import 'package:test/test.dart';

void main() {
  validationTests();
  radixTests();
  isValidTests();
}

void validationTests() {
  test('alphabet has duplicate characters', () {
    expect(
      () => Alphabet('0123453789'),
      throwsA(allOf(
        isArgumentError,
        predicate(
          (ArgumentError e) => e.name == 'alphabet',
          'argument is alphabet',
        ),
      )),
    );
  });

  test('radixPoint has no characters', () {
    expect(
      () => Alphabet('0123456789', radixPoint: ''),
      throwsA(allOf(
        isArgumentError,
        predicate(
          (ArgumentError e) => e.name == 'radixPoint',
          'argument is radixPoint',
        ),
      )),
    );
  });

  test('radixPoint has more than one character', () {
    expect(
      () => Alphabet('0123456789', radixPoint: '..'),
      throwsA(allOf(
        isArgumentError,
        predicate(
          (ArgumentError e) => e.name == 'radixPoint',
          'argument is radixPoint',
        ),
      )),
    );
  });

  test('radixPoint is part of alphabet', () {
    expect(
      () => Alphabet('0123456789', radixPoint: '5'),
      throwsA(allOf(
        isArgumentError,
        predicate(
          (ArgumentError e) => e.name == 'radixPoint',
          'argument is radixPoint',
        ),
      )),
    );
  });

  test('repetendSymbols has no characters', () {
    expect(
      () => Alphabet('0123456789', repetendSymbols: ''),
      throwsA(allOf(
        isArgumentError,
        predicate(
          (ArgumentError e) => e.name == 'repetendSymbols',
          'argument is repetendSymbols',
        ),
      )),
    );
  });

  test('repetendSymbols has more than two characters', () {
    expect(
      () => Alphabet('0123456789', repetendSymbols: '{()}'),
      throwsA(allOf(
        isArgumentError,
        predicate(
          (ArgumentError e) => e.name == 'repetendSymbols',
          'argument is repetendSymbols',
        ),
      )),
    );
  });

  test('a repetendSymbol is part of alphabet', () {
    expect(
      () => Alphabet('0123456789', repetendSymbols: '8'),
      throwsA(allOf(
        isArgumentError,
        predicate(
          (ArgumentError e) => e.name == 'repetendSymbols',
          'argument is repetendSymbols',
        ),
      )),
    );
  });

  test('a repetendSymbol and radixPoint are same', () {
    expect(
      () => Alphabet('0123456789', radixPoint: '{', repetendSymbols: '{}'),
      throwsA(allOf(
        isArgumentError,
        predicate(
          (ArgumentError e) => e.name == 'repetendSymbols',
          'argument is repetendSymbols',
        ),
      )),
    );
  });
}

void radixTests() {
  test('base-10', () {
    final Alphabet alphabet = Alphabet('0123456789');
    expect(alphabet.radix, equals(10));
  });

  test('base-2', () {
    final Alphabet alphabet = Alphabet('01');
    expect(alphabet.radix, equals(2));
  });

  test('base-16', () {
    final Alphabet alphabet = Alphabet('0123456789abcdef');
    expect(alphabet.radix, equals(16));
  });

  test('base-10 (emoji)', () {
    final Alphabet alphabet = Alphabet(
      '0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣',
      radixPoint: '*️⃣',
      repetendSymbols: '#️⃣',
    );
    expect(alphabet.radix, equals(10));
  });
}

void isValidTests() {
  test('valid base-10 numerals', () {
    final Alphabet alphabet = Alphabet('0123456789');

    final List<String> validNumerals = <String>[
      '123',
      '.123',
      '123.45',
      '123.45(67)',
      '123.(67)',
    ];

    validNumerals.forEach((String n) => expect(
        '$n is ${alphabet.isValid(n) ? 'valid' : 'invalid'}',
        equals('$n is valid')));
  });

  test('invalid base-10 numerals', () {
    final Alphabet alphabet = Alphabet('0123456789');

    final List<String> invalidNumerals = <String>[
      '',
      '123abc',
      '123.',
      '123(45)',
      '123.4.5',
      '123.45(67)8',
      '123.45(67',
      '123.4567(',
      '123.4567)',
      '123.45)67(',
      '123.45(67(',
      '123.45)67)',
      '123.4567()',
      '123.4567(())',
      '123.4567()()',
    ];

    invalidNumerals.forEach((String n) => expect(
        '$n is ${alphabet.isValid(n) ? 'valid' : 'invalid'}',
        equals('$n is invalid')));
  });

  test('valid base-10 (emoji) numerals', () {
    final Alphabet alphabet = Alphabet(
      '0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣',
      radixPoint: '*️⃣',
      repetendSymbols: '#️⃣',
    );

    final List<String> validNumerals = <String>[
      '2️⃣6️⃣4️⃣8️⃣',
      '*️⃣2️⃣6️⃣4️⃣8️⃣',
      '2️⃣6️⃣4️⃣8️⃣*️⃣9️⃣1️⃣',
      '2️⃣6️⃣4️⃣8️⃣*️⃣9️⃣1️⃣#️⃣0️⃣5️⃣#️⃣',
      '2️⃣6️⃣4️⃣8️⃣*️⃣#️⃣0️⃣5️⃣#️⃣',
    ];

    validNumerals.forEach((String n) => expect(
        '$n is ${alphabet.isValid(n) ? 'valid' : 'invalid'}',
        equals('$n is valid')));
  });

  test('invalid base-10 (emoji) numerals', () {
    final Alphabet alphabet = Alphabet(
      '0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣',
      radixPoint: '*️⃣',
      repetendSymbols: '#️⃣',
    );

    final List<String> invalidNumerals = <String>[
      '',
      '2️⃣6️⃣4️⃣8️⃣🔢',
      '2️⃣6️⃣4️⃣8️⃣*️⃣',
      '2️⃣6️⃣4️⃣8️⃣#️⃣0️⃣5️⃣#️⃣',
      '2️⃣6️⃣4️⃣8️⃣*️⃣9️⃣*️⃣1️⃣',
      '2️⃣6️⃣4️⃣8️⃣*️⃣9️⃣1️⃣#️⃣0️⃣5️⃣#️⃣1️⃣',
      '2️⃣6️⃣4️⃣8️⃣*️⃣9️⃣1️⃣#️⃣0️⃣5️⃣',
      '2️⃣6️⃣4️⃣8️⃣*️⃣9️⃣1️⃣0️⃣5️⃣#️⃣',
      '2️⃣6️⃣4️⃣8️⃣*️⃣9️⃣1️⃣0️⃣5️⃣#️⃣#️⃣',
    ];

    invalidNumerals.forEach((String n) => expect(
        '$n is ${alphabet.isValid(n) ? 'valid' : 'invalid'}',
        equals('$n is invalid')));
  });
}
