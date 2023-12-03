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

    (String, int) changeBase(List<int> _values) {
      final List<int> values = <int>[];
      for (int i = 0; i < _values.length; i++) {
        if (_values[i] != 0) {
          values.addAll(_values.sublist(i));
          break;
        }
      }

      if (values.isEmpty) {
        return ('', 0);
      }

      if (_intLengthFactor == 1 || _intLengthFactor == -1) {
        final StringBuffer sb = StringBuffer();
        for (final int value in values) {
          sb.write(_toAlphabet._characters[value]);
        }

        return (sb.toString(), values.length);
      } else if (_intLengthFactor == 0 ||
          values.length == 1 ||
          (_intLengthFactor < 0 && _intLengthFactor + values.length <= 0)) {
        // Horner's method
        int remainder = 0;
        final List<int> quotients = <int>[];
        for (final int value in values) {
          remainder = (remainder * fromBase) + value;

          quotients.add(remainder ~/ toBase);
          remainder = remainder % toBase;
        }

        final (String r, int rLen) = changeBase(quotients);

        return (r + _toAlphabet._characters[remainder], rLen + 1);
      } else if (_intLengthFactor > 0) {
        var (StringBuffer sb, int rLen) = (StringBuffer(), 0);
        for (int i = 0; i < values.length; i++) {
          final (String _r, int _rLen) = changeBase(values.sublist(i, i + 1));
          if (i > 0) {
            sb.write(_toAlphabet._zeroCharacter * (_intLengthFactor - _rLen));
            sb.write(_r);
            rLen += _intLengthFactor;
          } else {
            sb.write(_r);
            rLen += _rLen;
          }
        }

        return (sb.toString(), rLen);
      } else {
        // _intLengthFactor < 0
        var (StringBuffer sb, int rLen) = (StringBuffer(), 0);
        int i = values.length % (-_intLengthFactor);
        if (i > 0) {
          i += _intLengthFactor;
        }
        for (; i < values.length; i -= _intLengthFactor) {
          List<int> _values;
          if (i > 0) {
            _values = values.sublist(i, i - _intLengthFactor);
            final (String _r, int _rLen) = changeBase(_values);
            sb.write(_toAlphabet._zeroCharacter * (1 - _rLen));
            sb.write(_r);
            rLen += 1;
          } else {
            _values = values.sublist(0, i - _intLengthFactor);
            final (String _r, int _rLen) = changeBase(_values);
            sb.write(_r);
            rLen += _rLen;
          }
        }

        return (sb.toString(), rLen);
      }
    }

    final List<int> values = <int>[];
    for (final String char in ip.characters) {
      values.add(_fromAlphabet._characterset[char]!);
    }
    final int ipLen = values.length;

    var (String r, int rLen) = changeBase(values);

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
