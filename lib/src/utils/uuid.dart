import 'dart:math';

String uuid() {
  final random = Random();

  final special = 8 + random.nextInt(4);

  return '${_bitsDigits(16, 4, random)}${_bitsDigits(16, 4, random)}-'
      '${_bitsDigits(16, 4, random)}-'
      '4${_bitsDigits(12, 3, random)}-'
      '${_printDigits(special, 1)}${_bitsDigits(12, 3, random)}-'
      '${_bitsDigits(16, 4, random)}${_bitsDigits(16, 4, random)}${_bitsDigits(16, 4, random)}';
}

String _bitsDigits(int bitCount, int digitCount, Random random) =>
    _printDigits(_generateBits(bitCount, random), digitCount);

int _generateBits(int bitCount, Random random) => random.nextInt(1 << bitCount);

String _printDigits(int value, int count) =>
    value.toRadixString(16).padLeft(count, '0');
