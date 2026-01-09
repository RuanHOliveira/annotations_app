import 'package:annotations_app/src/data/models/annotation.dart';
import 'package:annotations_app/src/data/repositories/annotations_repository.dart';
import 'package:annotations_app/src/data/services/session_service.dart';
import 'package:mobx/mobx.dart';

part 'annotations_controller.g.dart';

class AnnotationsController = AnnotationsControllerBase
    with _$AnnotationsController;

abstract class AnnotationsControllerBase with Store {
  final AnnotationsRepository _annotationsRepository;
  final SessionService _sessionService;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  ObservableList<Annotation> annotations = ObservableList<Annotation>();

  AnnotationsControllerBase({
    required AnnotationsRepository annotationsRepository,
    required SessionService sessionService,
  }) : _annotationsRepository = annotationsRepository,
       _sessionService = sessionService;

  @action
  Future<void> load() async {
    isLoading = true;
    errorMessage = null;
    final userId = await _sessionService.getUserId();
    if (userId == null) {
      errorMessage = 'Usuário não encontrado';
      return;
    }

    try {
      final list = await _annotationsRepository.getByUserId(userId);
      annotations = ObservableList.of(list);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> create({
    required int userId,
    required String title,
    required String content,
  }) async {
    isLoading = true;
    errorMessage = null;

    final userId = await _sessionService.getUserId();
    if (userId == null) {
      errorMessage = 'Usuário não encontrado';
      return;
    }

    await _annotationsRepository.create(
      userId: userId,
      title: title,
      content: content,
    );

    await load();
  }

  @action
  Future<void> update(Annotation updated) async {
    isLoading = true;
    errorMessage = null;

    await _annotationsRepository.update(
      current: updated,
      title: updated.title,
      content: updated.content,
    );

    await load();
  }

  @action
  Future<void> delete(int annotationId) async {
    isLoading = true;
    errorMessage = null;

    await _annotationsRepository.delete(annotationId);

    await load();
  }
}
