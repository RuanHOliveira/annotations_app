import 'package:annotations_app/src/data/models/user.dart';
import 'package:annotations_app/src/data/repositories/user_repository.dart';
import 'package:annotations_app/src/data/services/session_service.dart';
import 'package:mobx/mobx.dart';

part 'register_controller.g.dart';

class RegisterController = RegisterControllerBase with _$RegisterController;

abstract class RegisterControllerBase with Store {
  final UserRepository _userRepository;
  final SessionService _sessionService;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  RegisterControllerBase({
    required UserRepository userRepository,
    required SessionService sessionService,
  }) : _userRepository = userRepository,
       _sessionService = sessionService;

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

    try {
      final user = await _userRepository.register(
        email: (email).trim(),
        name: name.trim(),
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
