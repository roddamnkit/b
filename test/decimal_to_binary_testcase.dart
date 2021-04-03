import 'package:b/b.dart';

final Map<String, dynamic> decimalToBinary = <String, dynamic>{
  'instance': BaseConversion(
    from: '0123456789',
    to: '01',
  ),
  'testCases': <Map<String, String>>[
    <String, String>{'from': '0', 'to': '0'},
    <String, String>{'from': '1', 'to': '1'},
    <String, String>{'from': '2', 'to': '10'},
    <String, String>{'from': '3', 'to': '11'},
    <String, String>{'from': '4', 'to': '100'},
    <String, String>{'from': '5', 'to': '101'},
    <String, String>{'from': '6', 'to': '110'},
    <String, String>{'from': '7', 'to': '111'},
    <String, String>{'from': '8', 'to': '1000'},
    <String, String>{'from': '9', 'to': '1001'},
    <String, String>{'from': '10', 'to': '1010'},
  ],
};
