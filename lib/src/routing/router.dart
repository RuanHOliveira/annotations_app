import 'package:annotations_app/src/routing/routes.dart';
import 'package:annotations_app/src/ui/features/auth/login/login_controller.dart';
import 'package:annotations_app/src/ui/features/auth/login/login_screen.dart';
import 'package:annotations_app/src/ui/features/auth/register/register_controller.dart';
import 'package:annotations_app/src/ui/features/auth/register/register_screen.dart';
import 'package:annotations_app/src/ui/features/main_navigation/main_navigation_controller.dart';
import 'package:annotations_app/src/ui/features/main_navigation/main_navigation_screen.dart';
import 'package:annotations_app/src/ui/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:provider/provider.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.splash,
  observers: [
    BotToastNavigatorObserver(), // mantém  BotToast funcionando
  ],
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) {
        return SplashScreen();
      },
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        return LoginScreen(loginController: context.read<LoginController>());
      },
    ),
    GoRoute(
      path: Routes.register,
      builder: (context, state) {
        return RegisterScreen(
          registerController: context.read<RegisterController>(),
        );
      },
    ),
    GoRoute(
      path: Routes.mainNavigation,
      builder: (context, state) {
        return MainNavigationScreen(
          mainNavigationController: context.read<MainNavigationController>(),
        );
      },
    ),
  ],
  errorPageBuilder: (context, state) => MaterialPage(
    child: Scaffold(body: Center(child: Text('Erro de rota: ${state.error}'))),
  ),
);
