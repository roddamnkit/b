# b - Base conversion

![Base conversion](./.img/b.svg)

[![Version](https://img.shields.io/pub/v/b)](https://pub.dev/packages/b)
[![Build Status](https://travis-ci.com/dkin-om/b.svg?branch=master)](https://travis-ci.com/dkin-om/b)
[![Coverage Status](https://coveralls.io/repos/github/dkin-om/b/badge.svg)](https://coveralls.io/github/dkin-om/b)
[![License](https://img.shields.io/badge/license-MIT-green)](https://github.com/dkin-om/b/blob/master/LICENSE)

A Dart library for converting between different bases, e.g., decimal ↔ binary, octal ↔ hexadecimal

## Usage

See `example/main.dart`

#### Hexadecimal ↔ Base58
```dart
final BaseConversion hexadecimalToBase58Converter = BaseConversion(
  from: '0123456789abcdef',
  to: base58,
);

final String base58Value = hexadecimalToBase58Converter('415a59758fb933b6049b050a556dd4d916b7b483f6966615');
// base58Value == '6xZA4Qt9vH7rePWeT5WLaVUZNjB6u6rGc'

final String hexadecimal = hexadecimalToBase58Converter.inverse()('GjWGF6jERR9ymrC1bHcGmsJYkLMDoaySr');
// hexadecimal == 'ac93c8d619c76f823f184110759b278f246cc7cc3cadcac3'
```

#### Decimal (emoji) ↔ Hexadecimal
```dart
final BaseConversion decimalEmojiToHexadecimalConverter = BaseConversion(
  from: '0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣',
  to: base16,
);

final String hexadecimal = decimalEmojiToHexadecimalConverter('5️⃣1️⃣9️⃣6️⃣6️⃣');
// hexadecimal == 'CAFE'

final String decimalEmoji = decimalEmojiToHexadecimalConverter.inverse()('DEADC0DE');
// decimalEmoji == '3️⃣7️⃣3️⃣5️⃣9️⃣2️⃣9️⃣0️⃣5️⃣4️⃣'
```

### Exported alphabets
- `base2` - `01`
- `base3` - `012`
- `base4` - `0123`
- `base5` - `01234`
- `base6` - `012345`
- `base8` - `01234567`
- `base10` - `0123456789`
- `base12` - `0123456789AB`
- `base16` - `0123456789ABCDEF`
- `base32` - `ABCDEFGHIJKLMNOPQRSTUVWXYZ234567`
- `base32hex` - `0123456789ABCDEFGHIJKLMNOPQRSTUV`
- `base36` - `0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ`
- `base58` - `123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz`
- `base64` - `ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/`
- `base64url` - `ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_`

## Syntax

### *`BaseConversion({required String from, required String to})`*

*`from`* - String of numeral symbols representing the digits of `from` numeral system.

*`to`* - String of numeral symbols representing the digits of `to` numeral system.

See [documentation](https://pub.dev/documentation/b) for more

## License

[MIT](https://github.com/dkin-om/b/blob/master/LICENSE)
