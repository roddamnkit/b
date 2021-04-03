import 'package:b/b.dart';

final Map<String, dynamic> decimalToDecimalEmoji = <String, dynamic>{
  'instance': BaseConversion.alphabet(
    from: Alphabet(
      '0123456789',
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
