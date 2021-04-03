import 'package:characters/characters.dart';
import 'package:invertible/invertible.dart';

/// Provides ability to convert numbers between different
/// positional numeral systems.
class BaseConversion extends InvertibleFunction<String, String> {
  /// Constructs a `BaseConversion` object with the given [from] and [to] alphabets.
  BaseConversion({required String from, required String to})
      : _fromAlphabet = Alphabet(from),
        _toAlphabet = Alphabet(to);

  /// Constructs a `BaseConversion` object with the given [from] and [to] alphabets.
  BaseConversion.alphabet({required Alphabet from, required Alphabet to})
      : _fromAlphabet = from,
        _toAlphabet = to;

  final Alphabet _fromAlphabet;

  final Alphabet _toAlphabet;

  @override
  List<bool Function(String)> get domain =>
      <bool Function(String)>[_fromAlphabet.isValid];

  @override
  String valueAt(String x) {
    final List<String> parts = x.split(_fromAlphabet._radixCharacter);
    String r = _convertIntegralPart(parts[0]);
    if (parts.length > 1) {
      r += _toAlphabet._radixCharacter + _convertFractionalPart(parts[1]);
    }
    return r;
  }

  // Horner's method
  String _convertIntegralPart(String ip) {
    final int fromBase = _fromAlphabet.radix;
    final int toBase = _toAlphabet.radix;

    String changeBase(Iterable<int> _values) {
      final Iterable<int> values = _values.skipWhile((int v) => v == 0);

      if (values.isEmpty) return '';

      int remainder = 0;
      final List<int> quotients = <int>[];
      for (final int value in values) {
        remainder = (remainder * fromBase) + value;

        quotients.add(remainder ~/ toBase);
        remainder = remainder % toBase;
      }

      return changeBase(quotients) + _toAlphabet._characters[remainder];
    }

    final String r =
        changeBase(ip.characters.map(_fromAlphabet._characters.indexOf));

    return r.isNotEmpty ? r : _toAlphabet._characters[0];
  }

  // TODO
  String _convertFractionalPart(String fp) => _toAlphabet._characters[0];

  @override
  BaseConversion inverse() =>
      BaseConversion.alphabet(from: _toAlphabet, to: _fromAlphabet);
}

///
class Alphabet {
  ///
  Alphabet(
    String alphabet, {
    String radixPoint = '.',
    String repetendSymbols = '()',
  })  : _characters = alphabet.characters.toList(),
        _radixCharacter = radixPoint.characters.length == 1
            ? radixPoint.characters.first
            : throw ArgumentError.value(
                radixPoint,
                'radixPoint',
                'Must have one and only one character for radix point',
              ),
        _repetendStartCharacter = repetendSymbols.characters.length == 1 ||
                repetendSymbols.characters.length == 2
            ? repetendSymbols.characters.first
            : throw ArgumentError.value(
                repetendSymbols,
                'repetendSymbols',
                'Must have one and only one character for a repetend symbol',
              ),
        _repetendEndCharacter = repetendSymbols.characters.length == 1 ||
                repetendSymbols.characters.length == 2
            ? repetendSymbols.characters.last
            : throw ArgumentError.value(
                repetendSymbols,
                'repetendSymbols',
                'Must have one and only one character for a repetend symbol',
              ) {
    if (_characters.length != _characters.toSet().length) {
      throw ArgumentError.value(
        alphabet,
        'alphabet',
        'Must not have duplicate characters in alphabet',
      );
    }
    if (_characters.contains(_radixCharacter)) {
      throw ArgumentError.value(
        radixPoint,
        'radixPoint',
        'Radix point must not be part of alphabet',
      );
    }
    if (_characters.contains(_repetendStartCharacter) ||
        _radixCharacter == _repetendStartCharacter ||
        _characters.contains(_repetendEndCharacter) ||
        _radixCharacter == _repetendEndCharacter) {
      throw ArgumentError.value(
        repetendSymbols,
        'repetendSymbols',
        'A repetend symbol must not be part of alphabet and be different from the radix point',
      );
    }
  }

  final List<String> _characters;

  final String _radixCharacter;

  final String _repetendStartCharacter;

  final String _repetendEndCharacter;

  /// Radix of this alphabet
  int get radix => _characters.length;

  /// Checks if [s] is a valid numeral representation
  bool isValid(String s) {
    String? previousCharacter;
    bool foundRadixCharacter = false;
    bool foundRepetendStartCharacter = false;
    bool foundRepetendEndCharacter = false;
    for (final String character in s.characters) {
      if (!_characters.contains(character) &&
          _radixCharacter != character &&
          _repetendStartCharacter != character &&
          _repetendEndCharacter != character) {
        return false;
      }
      if (_radixCharacter == character) {
        if (!foundRadixCharacter) {
          foundRadixCharacter = true;
        } else {
          return false;
        }
      } else if (_repetendStartCharacter == character ||
          _repetendEndCharacter == character) {
        if (_repetendStartCharacter == character &&
            foundRadixCharacter &&
            !foundRepetendStartCharacter) {
          foundRepetendStartCharacter = true;
        } else if (_repetendEndCharacter == character &&
            foundRepetendStartCharacter &&
            !foundRepetendEndCharacter &&
            _characters.contains(previousCharacter)) {
          foundRepetendEndCharacter = true;
        } else {
          return false;
        }
      }
      previousCharacter = character;
    }
    return previousCharacter != null &&
        previousCharacter != _radixCharacter &&
        (!foundRepetendStartCharacter ||
            (foundRepetendEndCharacter &&
                previousCharacter == _repetendEndCharacter));
  }
}
