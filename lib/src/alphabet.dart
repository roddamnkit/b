part of b;

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

/// Binary numeral system
const String binary = '01';

/// Same as [binary] numeral system
const String base2 = binary;

/// Ternary numeral system
const String ternary = '012';

/// Same as [ternary] numeral system
const String base3 = ternary;

/// Quaternary numeral system
const String quaternary = '0123';

/// Same as [quaternary] numeral system
const String base4 = quaternary;

/// Quinary numeral system
const String quinary = '01234';

/// Same as [quinary] numeral system
const String base5 = quinary;

/// Senary numeral system
const String senary = '012345';

/// Same as [senary] numeral system
const String base6 = senary;

/// Octal numeral system
const String octal = '01234567';

/// Same as [octal] numeral system
const String base8 = octal;

/// Decimal numeral system
const String decimal = '0123456789';

/// Same as [decimal] numeral system
const String base10 = decimal;

/// Duodecimal numeral system
const String duodecimal = '0123456789AB';

/// Same as [duodecimal] numeral system
const String base12 = duodecimal;

/// Hexadecimal numeral system
const String hexadecimal = '0123456789ABCDEF';

/// Same as [hexadecimal] numeral system
const String base16 = hexadecimal;

/// Base32 numeral system
const String base32 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';

/// Base32 (Extended Hex) numeral system
const String base32hex = '0123456789ABCDEFGHIJKLMNOPQRSTUV';

/// Base36 numeral system
const String base36 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

/// Base58 numeral system
const String base58 =
    '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';

/// Base62 numeral system
const String base62 =
    '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

/// Base64 numeral system
const String base64 =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

/// Base64 (URL and Filename safe) numeral system
const String base64url =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_';
