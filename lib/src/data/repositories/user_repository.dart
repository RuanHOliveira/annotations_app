import 'package:annotations_app/src/data/daos/users_dao.dart';
import 'package:annotations_app/src/data/models/user.dart';
import 'package:annotations_app/src/utils/security/password_hasher.dart';

class UserRepository {
  final UsersDao _usersDao;

  UserRepository({UsersDao userDao = const UsersDao()}) : _usersDao = userDao;

  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();

    final exists = await _usersDao.findByEmail(normalizedEmail);
    if (exists != null) {
      throw Exception('Email já utilizado!');
    }

    final hashedPassword = PasswordHasher.hash(password);

    final user = User(
      name: name.trim(),
      email: normalizedEmail,
      password: hashedPassword,
      createdAt: DateTime.now(),
    );

    final id = await _usersDao.insert(user);
    return user.copyWith(id: id);
  }

  Future<User> login({required String email, required String password}) async {
    final user = await _usersDao.findByEmail(email);
    if (user == null) {
      throw Exception('Usuário não encontrado!');
    }

    final hashedPassword = PasswordHasher.hash(password);

    if (user.password != hashedPassword) {
      throw Exception('Credenciais inválidas');
    }

    return user;
  }
}
