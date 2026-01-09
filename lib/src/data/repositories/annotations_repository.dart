import 'package:annotations_app/src/data/daos/annotations_dao.dart';
import 'package:annotations_app/src/data/models/annotation.dart';
import 'package:annotations_app/src/data/models/annotations_details.dart';

class AnnotationsRepository {
  final AnnotationsDao _annotationsDao;

  AnnotationsRepository({
    AnnotationsDao annotationsDao = const AnnotationsDao(),
  }) : _annotationsDao = annotationsDao;

  Future<Annotation?> getById(int id) {
    return _annotationsDao.findById(id);
  }

  Future<List<Annotation>> getByUserId(int userId) {
    return _annotationsDao.findByUserId(userId);
  }

  Future<int> create({
    required int userId,
    required String title,
    required String content,
  }) async {
    final now = DateTime.now();

    final annotation = Annotation(
      userId: userId,
      title: title.trim(),
      content: content.trim(),
      editCount: 0,
      createdAt: now,
      updatedAt: now,
      deletedAt: null,
    );

    return _annotationsDao.insert(annotation);
  }

  Future<void> update({
    required Annotation current,
    required String title,
    required String content,
  }) async {
    final updated = current.copyWith(
      title: title.trim(),
      content: content.trim(),
      editCount: current.editCount + 1,
      updatedAt: DateTime.now(),
    );

    await _annotationsDao.update(updated);
  }

  Future<void> delete(int id) async {
    await _annotationsDao.softDelete(id);
  }

  Future<AnnotationsDetails> getDetails(int userId) async {
    final activeList = await _annotationsDao.findByUserId(userId);
    final deletedList = await _annotationsDao.findDeletedByUserId(userId);

    final totalActive = activeList.length;
    final totalDeleted = deletedList.length;
    final totalCreated = totalActive + totalDeleted;

    final totalEdits = _sumEdits(activeList) + _sumEdits(deletedList);

    final activeText = _calcText(activeList);
    final deletedText = _calcText(deletedList);

    final totalCharsAll = activeText.chars + deletedText.chars;
    final totalLettersAll = activeText.letters + deletedText.letters;
    final totalNumbersAll = activeText.numbers + deletedText.numbers;

    return AnnotationsDetails(
      totalCreated: totalCreated,
      totalActive: totalActive,
      totalDeleted: totalDeleted,
      totalEdits: totalEdits,

      totalCharsActive: activeText.chars,
      totalCharsDeleted: deletedText.chars,
      totalCharsAll: totalCharsAll,

      totalLettersActive: activeText.letters,
      totalLettersDeleted: deletedText.letters,
      totalLettersAll: totalLettersAll,

      totalNumbersActive: activeText.numbers,
      totalNumbersDeleted: deletedText.numbers,
      totalNumbersAll: totalNumbersAll,
    );
  }

  int _sumEdits(List<Annotation> list) {
    return list.fold<int>(0, (sum, a) => sum + a.editCount);
  }

  ({int chars, int letters, int numbers}) _calcText(List<Annotation> list) {
    int chars = 0;
    int letters = 0;
    int numbers = 0;

    for (final item in list) {
      final text = item.content;

      chars += text.length;
      letters += RegExp(r'\p{L}', unicode: true).allMatches(text).length;
      numbers += RegExp(r'\p{N}', unicode: true).allMatches(text).length;
    }

    return (chars: chars, letters: letters, numbers: numbers);
  }
}
