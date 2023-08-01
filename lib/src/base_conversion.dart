part of b;

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
