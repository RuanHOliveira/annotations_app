import 'dart:convert';
import 'package:crypto/crypto.dart';

class Utils {
  static String hash(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static int countLetters(String text) {
    final reg = RegExp(r'\p{L}', unicode: true);
    return reg.allMatches(text).length;
  }

  static int countNumbers(String text) {
    final reg = RegExp(r'\p{N}', unicode: true);
    return reg.allMatches(text).length;
  }
}
