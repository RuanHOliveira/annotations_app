import 'dart:convert';
import 'package:annotations_app/src/data/models/annotation.dart';
import 'package:annotations_app/src/data/models/annotations_details.dart';
import 'package:crypto/crypto.dart';

class Utils {
  static String hash(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static int sumEdits(List<Annotation> list) {
    return list.fold<int>(0, (sum, a) => sum + a.editCount);
  }

  static int countLetters(String text) {
    final reg = RegExp(r'\p{L}', unicode: true);
    return reg.allMatches(text).length;
  }

  static int countNumbers(String text) {
    final reg = RegExp(r'\p{N}', unicode: true);
    return reg.allMatches(text).length;
  }

  static int countEmpty(String text) {
    final reg = RegExp(r'\s', unicode: true);
    return reg.allMatches(text).length;
  }

  static int countSpecial(String text) {
    final reg = RegExp(r'[^\p{L}\p{N}\s]', unicode: true);
    return reg.allMatches(text).length;
  }

  static ({int chars, int letters, int numbers, int empty, int special})
  calcText(List<Annotation> list) {
    int chars = 0;
    int letters = 0;
    int numbers = 0;
    int empty = 0;
    int special = 0;

    for (final item in list) {
      final text = item.content;

      chars += text.length;
      letters += countLetters(text);
      numbers += countNumbers(text);
      empty += countEmpty(text);
      special += countSpecial(text);
    }

    return (
      chars: chars,
      letters: letters,
      numbers: numbers,
      empty: empty,
      special: special,
    );
  }

  static int editsByFilter(
    AnnotationsDetails annotationsDetails,
    String filter,
  ) {
    switch (filter) {
      case 'Ativos':
        return annotationsDetails.totalEditsActive;
      case 'Deletados':
        return annotationsDetails.totalEditsDeleted;
      case 'Todos':
      default:
        return annotationsDetails.totalEditsAll;
    }
  }

  static int charsByFilter(
    AnnotationsDetails annotationsDetails,
    String filter,
  ) {
    switch (filter) {
      case 'Ativos':
        return annotationsDetails.totalCharsActive;
      case 'Deletados':
        return annotationsDetails.totalCharsDeleted;
      case 'Todos':
      default:
        return annotationsDetails.totalCharsAll;
    }
  }

  static int lettersByFilter(
    AnnotationsDetails annotationsDetails,
    String filter,
  ) {
    switch (filter) {
      case 'Ativos':
        return annotationsDetails.totalLettersActive;
      case 'Deletados':
        return annotationsDetails.totalLettersDeleted;
      case 'Todos':
      default:
        return annotationsDetails.totalLettersAll;
    }
  }

  static int numbersByFilter(
    AnnotationsDetails annotationsDetails,
    String filter,
  ) {
    switch (filter) {
      case 'Ativos':
        return annotationsDetails.totalNumbersActive;
      case 'Deletados':
        return annotationsDetails.totalNumbersDeleted;
      case 'Todos':
      default:
        return annotationsDetails.totalNumbersAll;
    }
  }

  static int emptyByFilter(
    AnnotationsDetails annotationsDetails,
    String filter,
  ) {
    switch (filter) {
      case 'Ativos':
        return annotationsDetails.totalEmptyActive;
      case 'Deletados':
        return annotationsDetails.totalEmptyDeleted;
      case 'Todos':
      default:
        return annotationsDetails.totalEmptyAll;
    }
  }

  static int specialByFilter(
    AnnotationsDetails annotationsDetails,
    String filter,
  ) {
    switch (filter) {
      case 'Ativos':
        return annotationsDetails.totalSpecialActive;
      case 'Deletados':
        return annotationsDetails.totalSpecialDeleted;
      case 'Todos':
      default:
        return annotationsDetails.totalSpecialAll;
    }
  }
}
