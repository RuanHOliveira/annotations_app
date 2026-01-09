import 'package:annotations_app/src/data/models/user.dart';
import 'package:annotations_app/src/data/repositories/user_repository.dart';
import 'package:annotations_app/src/data/services/session_service.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final UserRepository _userRepository;
  final SessionService _sessionService;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  LoginControllerBase({
    required UserRepository userRepository,
    required SessionService sessionService,
  }) : _userRepository = userRepository,
       _sessionService = sessionService;

  @action
  void clearError() => errorMessage = null;

  @action
  Future<User?> login({required String email, required String password}) async {
    isLoading = true;
    errorMessage = null;

    try {
      final user = await _userRepository.login(
        email: (email).trim(),
        password: password,
      );
      await _sessionService.saveUserId(user.id!);
      return user;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      return null;
    } finally {
      isLoading = false;
    }
  }
}
