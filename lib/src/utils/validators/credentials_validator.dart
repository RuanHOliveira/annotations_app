import 'package:annotations_app/src/utils/validators/credentials_model.dart';
import 'package:lucid_validation/lucid_validation.dart';

class CredentialsValidator extends LucidValidator<CredentialsModel> {
  CredentialsValidator() {
    ruleFor(
      (model) => model.name,
      key: 'name',
    ).notEmpty(message: 'Campo obrigatório!');

    ruleFor((model) => model.email, key: 'email')
        .notEmpty(message: 'Campo obrigatório!')
        .validEmail(message: 'Email inválido!')
        .matchesPattern(
          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
          message: 'Email inválido!',
        );

    ruleFor(
      (model) => model.password,
      key: 'password',
    ).notEmpty(message: 'Campo obrigatório!');

    ruleFor((model) => model.registerPassword, key: 'registerPassword')
        .notEmpty(message: 'Campo obrigatório!')
        .minLength(8, message: 'Senha deve ter no mínimo 8 caracteres.')
        .mustHaveLowercase(
          message: 'Senha deve conter pelo menos 1 letra minúscula.',
        )
        .mustHaveUppercase(
          message: 'Senha deve conter pelo menos 1 letra maiúscula.',
        )
        .mustHaveNumber(message: 'Senha deve conter pelo menos 1 número.')
        .mustHaveSpecialCharacter(
          message: 'Senha deve conter pelo menos 1 caractere especial.',
        )
        .matchesPattern(
          r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$",
          message: 'Formato inválido!',
        );

    ruleFor((model) => model.confirmPassword, key: 'confirmPassword') //
        .notEmpty(message: 'Campo obrigatório!')
        .equalTo(
          (credentials) => credentials.registerPassword,
          message: 'Senhas campos não coincidem!',
        );
  }
}
