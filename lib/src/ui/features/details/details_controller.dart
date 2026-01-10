import 'package:annotations_app/src/data/models/annotations_details.dart';
import 'package:annotations_app/src/data/repositories/annotations_repository.dart';
import 'package:annotations_app/src/data/services/session_service.dart';
import 'package:mobx/mobx.dart';

part 'details_controller.g.dart';

class DetailsController = DetailsControllerBase with _$DetailsController;

abstract class DetailsControllerBase with Store {
  final AnnotationsRepository _annotationsRepository;
  final SessionService _sessionService;

  @observable
  AnnotationsDetails annotationsDetails = AnnotationsDetails.empty();

  @observable
  String selectedFilter = 'Todos';

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  DetailsControllerBase({
    required AnnotationsRepository annotationsRepository,
    required SessionService sessionService,
  }) : _annotationsRepository = annotationsRepository,
       _sessionService = sessionService;

  @action
  Future<void> load() async {
    isLoading = true;
    errorMessage = null;

    try {
      final userId = await _sessionService.getUserId();
      if (userId == null) {
        errorMessage = 'Usuário não encontrado';
        return;
      }

      annotationsDetails = await _annotationsRepository.getDetails(userId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  void changeFilter(String newFilter) => selectedFilter = newFilter;
}
