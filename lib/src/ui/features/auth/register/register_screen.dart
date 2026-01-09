import 'package:annotations_app/src/routing/routes.dart';
import 'package:annotations_app/src/ui/core/themes/app_text_styles.dart';
import 'package:annotations_app/src/ui/core/widgets/buttons/multi_text_button.dart';
import 'package:annotations_app/src/ui/core/widgets/buttons/primary_button.dart';
import 'package:annotations_app/src/ui/core/widgets/inputs/custom_text_form_field.dart';
import 'package:annotations_app/src/ui/core/widgets/inputs/password_form_field.dart';
import 'package:annotations_app/src/ui/core/widgets/useful/custom_toast.dart';
import 'package:annotations_app/src/ui/features/auth/register/register_controller.dart';
import 'package:annotations_app/src/utils/validators/credentials_model.dart';
import 'package:annotations_app/src/utils/validators/credentials_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  final RegisterController _registerController;

  const RegisterScreen({
    super.key,
    required RegisterController registerController,
  }) : _registerController = registerController;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final CredentialsModel _credentialsModel = CredentialsModel();
  final CredentialsValidator _credentialsValidator = CredentialsValidator();
  final CustomToast _customToast = CustomToast();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cs.surface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: cs.primary),
          onPressed: () => context.go(Routes.login),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: deviceSize.width * 0.02,
              vertical: deviceSize.height * 0.01,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Icon(
                  Icons.lock_open,
                  size: deviceSize.width * 0.2,
                  color: cs.onPrimary,
                ),
                const SizedBox(height: 8),
                // Título
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Cadastre-se',
                    style: AppTextStyles.textBold22.copyWith(
                      color: cs.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: _credentialsModel.setName,
                        controller: _nameController,
                        hintText: 'Nome',
                        validator: _credentialsValidator.byField(
                          _credentialsModel,
                          'name',
                        ),
                      ),
                      CustomTextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: _credentialsModel.setEmail,
                        controller: _emailController,
                        hintText: 'Email',
                        validator: _credentialsValidator.byField(
                          _credentialsModel,
                          'email',
                        ),
                      ),
                      PasswordFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: _credentialsModel.setRegisterPassword,
                        controller: _passwordController,
                        hintText: 'Senha',
                        validator: _credentialsValidator.byField(
                          _credentialsModel,
                          'registerPassword',
                        ),
                      ),
                      PasswordFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: _credentialsModel.setConfirmPassword,
                        controller: _confirmPasswordController,
                        hintText: 'Confirme a senha',
                        validator: _credentialsValidator.byField(
                          _credentialsModel,
                          'confirmPassword',
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16.0),
                // Acessar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Observer(
                    builder: (_) {
                      return PrimaryButton(
                        text: 'Cadastrar',
                        isLoading: widget._registerController.isLoading,
                        disable: widget._registerController.isLoading,
                        onPressed: _tryRegister,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 50),

                // Registro
                MultiTextButton(
                  onPressed: () async => context.go(Routes.login),
                  children: [
                    Text(
                      'Já possui conta? ',
                      style: AppTextStyles.text14.copyWith(color: cs.primary),
                    ),
                    Text(
                      'Entrar',
                      style: AppTextStyles.textBold14.copyWith(
                        color: cs.onPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _tryRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final user = await widget._registerController.register(
      email: _emailController.text,
      name: _nameController.text,
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (user != null) {
      if (!mounted) return;
      context.go(Routes.mainNavigation);
    } else {
      if (!mounted) return;
      _customToast.showToast(
        context,
        message: widget._registerController.errorMessage ?? 'Falha no login',
        toastType: 'error',
      );
    }
  }
}
