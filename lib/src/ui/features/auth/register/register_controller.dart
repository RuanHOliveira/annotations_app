import 'package:annotations_app/src/data/models/user.dart';
import 'package:annotations_app/src/data/repositories/user_repository.dart';
import 'package:mobx/mobx.dart';

part 'register_controller.g.dart';

class RegisterController = RegisterControllerBase with _$RegisterController;

abstract class RegisterControllerBase with Store {
  final UserRepository _userRepository;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  RegisterControllerBase({required UserRepository userRepository})
    : _userRepository = userRepository;

  @action
  void clearError() => errorMessage = null;

  @action
  Future<User?> register({
    required String email,
    required String password,
    required String name,
  }) async {
    isLoading = true;
    errorMessage = null;

    // Delay apenas para simular requisição de register
    await Future.delayed(Duration(seconds: 2));

    try {
      final result = await _userRepository.register(
        email: (email).trim(),
        name: name.trim(),
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
