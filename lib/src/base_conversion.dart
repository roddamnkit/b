part of b;

/// Provides ability to convert numbers between different
/// positional numeral systems.
class BaseConversion extends InvertibleFunction<String, String> {
  /// Constructs a `BaseConversion` object with the given [from] and [to] alphabets.
  BaseConversion({
    required String from,
    required String to,
    bool zeroPadding = false,
  }) : this.alphabet(
          from: Alphabet(from),
          to: Alphabet(to),
          zeroPadding: zeroPadding,
        );

  /// Constructs a `BaseConversion` object with the given [from] and [to] alphabets.
  BaseConversion.alphabet({
    required Alphabet from,
    required Alphabet to,
    bool zeroPadding = false,
  })  : _fromAlphabet = from,
        _toAlphabet = to,
        _lengthFactor = __lengthFactor(from: from, to: to),
        _intLengthFactor = (() {
          final double lengthFactor = __lengthFactor(from: from, to: to);
          int intLengthFactor = lengthFactor.truncate();
          if (lengthFactor == intLengthFactor) {
            return intLengthFactor;
          } else {
            final double invLengthFactor = (1 / lengthFactor);
            intLengthFactor = -invLengthFactor.truncate();
            if (invLengthFactor == -intLengthFactor) {
              return intLengthFactor;
            }
          }
          return 0;
        })(),
        _zeroPadding = zeroPadding;

  final Alphabet _fromAlphabet;
  final Alphabet _toAlphabet;

  final double _lengthFactor;
  final int _intLengthFactor;

  final bool _zeroPadding;

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

  String _convertIntegralPart(String ip) {
    final int fromBase = _fromAlphabet.radix;
    final int toBase = _toAlphabet.radix;

    (String, int) changeBase(Iterable<int> _values) {
      // Horner's method
      final Iterable<int> values = _values.skipWhile((int v) => v == 0);

      if (values.isEmpty) {
        return ('', 0);
      }

      int remainder = 0;
      final List<int> quotients = <int>[];
      for (final int value in values) {
        remainder = (remainder * fromBase) + value;

        quotients.add(remainder ~/ toBase);
        remainder = remainder % toBase;
      }

      final (String r, int rLen) = changeBase(quotients);

      return (r + _toAlphabet._characters[remainder], rLen + 1);
    }

    final int ipLen = ip.characters.length;

    var (String r, int rLen) =
        changeBase(ip.characters.map(_fromAlphabet._characters.indexOf));

    if (_zeroPadding) {
      final int currentLength = rLen;
      final int wantedLength = (ipLen * _lengthFactor).ceil();

      if (currentLength < wantedLength) {
        final StringBuffer sb = StringBuffer();
        sb.write(_toAlphabet._zeroCharacter * (wantedLength - currentLength));
        sb.write(r);

        r = sb.toString();
      }
    } else if (rLen == 0) {
      r = _toAlphabet._zeroCharacter;
    }

    return r;
  }

  // TODO
  String _convertFractionalPart(String fp) => _toAlphabet._zeroCharacter;

  @override
  BaseConversion inverse() => BaseConversion.alphabet(
        from: _toAlphabet,
        to: _fromAlphabet,
        zeroPadding: _zeroPadding,
      );
}

double __lengthFactor({required Alphabet from, required Alphabet to}) =>
    log(from.radix) / log(to.radix);
