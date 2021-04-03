# b - Base conversion

[![Version](https://img.shields.io/pub/v/b)](https://pub.dev/packages/b)
[![Build Status](https://travis-ci.com/dkin-om/b.svg?branch=master)](https://travis-ci.com/dkin-om/b)
[![Coverage Status](https://coveralls.io/repos/github/dkin-om/b/badge.svg)](https://coveralls.io/github/dkin-om/b)
[![License](https://img.shields.io/badge/license-MIT-green)](https://github.com/dkin-om/b/blob/master/LICENSE)

A Dart library for converting between different bases, e.g., decimal ↔ binary, octal ↔ hexadecimal

## Usage

See `example/main.dart`

### Decimal (emoji) ↔ Hexadecimal

```dart
final BaseConversion decimalEmojiToHexadecimalConverter = BaseConversion(
  from: '0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣',
  to: '0123456789ABCDEF',
);

final String hexadecimal = decimalEmojiToHexadecimalConverter('5️⃣1️⃣9️⃣6️⃣6️⃣');
// hexadecimal == 'CAFE'

final String decimalEmoji = decimalEmojiToHexadecimalConverter.inverse()('DEADC0DE');
// decimalEmoji == '3️⃣7️⃣3️⃣5️⃣9️⃣2️⃣9️⃣0️⃣5️⃣4️⃣'
```

## Syntax

### *`BaseConversion({required String from, required String to})`*

*`from`* - String of numeral symbols representing the digits of `from` numeral system.

*`to`* - String of numeral symbols representing the digits of `to` numeral system.

See [documentation](https://pub.dev/documentation/b) for more

## License

[MIT](https://github.com/dkin-om/b/blob/master/LICENSE)
