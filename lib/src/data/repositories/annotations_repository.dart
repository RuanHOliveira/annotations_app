import 'package:annotations_app/src/data/daos/annotations_dao.dart';
import 'package:annotations_app/src/data/models/annotation.dart';
import 'package:annotations_app/src/data/models/annotations_details.dart';
import 'package:annotations_app/src/utils/%20utils.dart';

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
      content: content,
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
      content: content,
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

    final totalEditsActive = Utils.sumEdits(activeList);
    final totalEditsDeleted = Utils.sumEdits(deletedList);
    final totalEditsAll =
        Utils.sumEdits(activeList) + Utils.sumEdits(deletedList);

    final activeText = Utils.calcText(activeList);
    final deletedText = Utils.calcText(deletedList);

    final totalCharsAll = activeText.chars + deletedText.chars;
    final totalLettersAll = activeText.letters + deletedText.letters;
    final totalNumbersAll = activeText.numbers + deletedText.numbers;
    final totalEmptyAll = activeText.empty + deletedText.empty;
    final totalSpecialAll = activeText.special + deletedText.special;

    return AnnotationsDetails(
      totalCreated: totalCreated,
      totalActive: totalActive,
      totalDeleted: totalDeleted,

      totalEditsActive: totalEditsActive,
      totalEditsDeleted: totalEditsDeleted,
      totalEditsAll: totalEditsAll,

      totalCharsActive: activeText.chars,
      totalCharsDeleted: deletedText.chars,
      totalCharsAll: totalCharsAll,

      totalLettersActive: activeText.letters,
      totalLettersDeleted: deletedText.letters,
      totalLettersAll: totalLettersAll,

      totalNumbersActive: activeText.numbers,
      totalNumbersDeleted: deletedText.numbers,
      totalNumbersAll: totalNumbersAll,

      totalEmptyActive: activeText.empty,
      totalEmptyDeleted: deletedText.empty,
      totalEmptyAll: totalEmptyAll,

      totalSpecialActive: activeText.special,
      totalSpecialDeleted: deletedText.special,
      totalSpecialAll: totalSpecialAll,
    );
  }
}
