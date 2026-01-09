import 'package:annotations_app/src/data/repositories/annotations_repository.dart';
import 'package:annotations_app/src/data/services/session_service.dart';
import 'package:mobx/mobx.dart';

part 'details_controller.g.dart';

class DetailsController = DetailsControllerBase with _$DetailsController;

abstract class DetailsControllerBase with Store {
  final AnnotationsRepository _annotationsRepository;
  final SessionService _sessionService;

  DetailsControllerBase({
    required AnnotationsRepository annotationsRepository,
    required SessionService sessionService,
  }) : _annotationsRepository = annotationsRepository,
       _sessionService = sessionService;
}
