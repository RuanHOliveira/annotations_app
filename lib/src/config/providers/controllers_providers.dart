import 'package:annotations_app/src/data/repositories/user_repository.dart';
import 'package:annotations_app/src/ui/features/auth/login/login_controller.dart';
import 'package:annotations_app/src/ui/features/auth/register/register_controller.dart';
import 'package:annotations_app/src/ui/features/main_navigation/main_navigation_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> buildControllersProviders() => [
  Provider<LoginController>(
    create: (context) =>
        LoginController(userRepository: context.read<UserRepository>()),
  ),
  Provider<RegisterController>(
    create: (context) =>
        RegisterController(userRepository: context.read<UserRepository>()),
  ),

  Provider<MainNavigationController>(
    create: (context) => MainNavigationController(),
  ),
];
