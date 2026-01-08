import 'package:annotations_app/src/data/models/user.dart';
import 'package:annotations_app/src/data/repositories/user_repository.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final UserRepository _userRepository;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  LoginControllerBase({required UserRepository userRepository})
    : _userRepository = userRepository;

  @action
  void clearError() => errorMessage = null;

  @action
  Future<User?> login({required String email, required String password}) async {
    isLoading = true;
    errorMessage = null;

    // Delay apenas para simular requisição de login
    await Future.delayed(Duration(seconds: 2));

    try {
      final result = await _userRepository.login(
        email: (email).trim(),
        password: password,
      );
      return result;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      return null;
    } finally {
      isLoading = false;
    }
  }
}
