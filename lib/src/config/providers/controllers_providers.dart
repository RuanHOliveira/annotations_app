import 'package:annotations_app/src/data/repositories/annotations_repository.dart';
import 'package:annotations_app/src/data/repositories/user_repository.dart';
import 'package:annotations_app/src/data/services/session_service.dart';
import 'package:annotations_app/src/ui/features/annotations/annotations_controller.dart';
import 'package:annotations_app/src/ui/features/auth/login/login_controller.dart';
import 'package:annotations_app/src/ui/features/auth/register/register_controller.dart';
import 'package:annotations_app/src/ui/features/details/details_controller.dart';
import 'package:annotations_app/src/ui/features/main_navigation/main_navigation_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> buildControllersProviders() => [
  Provider<LoginController>(
    create: (context) => LoginController(
      userRepository: context.read<UserRepository>(),
      sessionService: context.read<SessionService>(),
    ),
  ),
  Provider<RegisterController>(
    create: (context) => RegisterController(
      userRepository: context.read<UserRepository>(),
      sessionService: context.read<SessionService>(),
    ),
  ),

  Provider<AnnotationsController>(
    create: (context) => AnnotationsController(
      annotationsRepository: context.read<AnnotationsRepository>(),
      sessionService: context.read<SessionService>(),
    ),
  ),
  Provider<DetailsController>(
    create: (context) => DetailsController(
      annotationsRepository: context.read<AnnotationsRepository>(),
      sessionService: context.read<SessionService>(),
    ),
  ),

  Provider<MainNavigationController>(
    create: (context) => MainNavigationController(
      annotationsController: context.read<AnnotationsController>(),
      detailsController: context.read<DetailsController>(),
      sessionService: context.read<SessionService>(),
    ),
  ),
];
