import 'package:b/b.dart';

void main() {
  decimalAndBinary();
  decimalAndDecimalEmoji();
  decimalEmojiAndHexadecimal();
}

void decimalAndBinary() {
  // Decimal alphabet - 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
  // Binary alphabet - 0, 1
  final BaseConversion decimalToBinaryConverter = BaseConversion(
    from: base10,
    to: base2,
  );

  final String binary = decimalToBinaryConverter('3888');
  print(
      'decimal number 3888 is represented as $binary in binary'); // 111100110000

  final String decimal = decimalToBinaryConverter.inverse()('111110011111');
  print(
      'binary number 111110011111 is represented as $decimal in decimal'); // 3999
}

void decimalAndDecimalEmoji() {
  // Decimal alphabet - 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
  // Decimal emoji alphabet - 0️⃣, 1️⃣, 2️⃣, 3️⃣, 4️⃣, 5️⃣, 6️⃣, 7️⃣, 8️⃣, 9️⃣
  final BaseConversion decimalToDecimalEmojiConverter = BaseConversion(
    from: base10,
    to: '0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣',
  );

  final String decimalEmoji = decimalToDecimalEmojiConverter('38888');
  print(
      'decimal number 38888 is represented as $decimalEmoji in decimal emoji'); // 3️⃣8️⃣8️⃣8️⃣8️⃣

  final String decimal =
      decimalToDecimalEmojiConverter.inverse()('3️⃣9️⃣9️⃣9️⃣9️⃣');
  print(
      'decimal emoji number 3️⃣9️⃣9️⃣9️⃣9️⃣ is represented as $decimal in decimal'); // 39999
}

void decimalEmojiAndHexadecimal() {
  // Decimal emoji alphabet - 0️⃣, 1️⃣, 2️⃣, 3️⃣, 4️⃣, 5️⃣, 6️⃣, 7️⃣, 8️⃣, 9️⃣
  // Hexadecimal alphabet - 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, A, B, C, D, E, F
  final BaseConversion decimalEmojiToHexadecimalConverter = BaseConversion(
    from: '0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣',
    to: base16,
  );

  final String hexadecimal =
      decimalEmojiToHexadecimalConverter('5️⃣1️⃣9️⃣6️⃣6️⃣');
  print(
      'decimal emoji number 5️⃣1️⃣9️⃣6️⃣6️⃣ is represented as $hexadecimal in hexadecimal'); // CAFE

  final String decimalEmoji =
      decimalEmojiToHexadecimalConverter.inverse()('DEADC0DE');
  print(
      'hexadecimal number DEADC0DE is represented as $decimalEmoji in decimal emoji'); // 3️⃣7️⃣3️⃣5️⃣9️⃣2️⃣9️⃣0️⃣5️⃣4️⃣
}
