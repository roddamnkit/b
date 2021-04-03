import 'package:test/test.dart';

import 'decimal_to_binary_testcase.dart';
import 'decimal_to_decimal_emoji_testcase.dart';

void main() {
  testConverter(decimalToBinary);
  testConverter(decimalToDecimalEmoji);
}

void testConverter(Map<String, dynamic> converter) {
  group('function', () {
    converter['testCases'].forEach((Map<String, String> testCase) {
      test('${testCase['from']} -> ${testCase['to']}', () {
        expect(converter['instance'](testCase['from']), equals(testCase['to']));
      });
    });
  });

  group('inverse function', () {
    converter['testCases'].forEach((Map<String, String> testCase) {
      test('${testCase['to']} -> ${testCase['from']}', () {
        expect(converter['instance'].inverse()(testCase['to']),
            equals(testCase['from']));
      });
    });
  });
}
