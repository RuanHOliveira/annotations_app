import 'package:annotations_app/src/routing/routes.dart';
import 'package:annotations_app/src/ui/core/components/inputs/custom_text_form_field.dart';
import 'package:annotations_app/src/ui/core/themes/app_text_styles.dart';
import 'package:annotations_app/src/ui/core/components/buttons/multi_text_button.dart';
import 'package:annotations_app/src/ui/core/components/buttons/primary_button.dart';
import 'package:annotations_app/src/ui/core/components/inputs/password_form_field.dart';
import 'package:annotations_app/src/ui/core/components/useful/custom_toast.dart';
import 'package:annotations_app/src/ui/features/auth/login/login_controller.dart';
import 'package:annotations_app/src/utils/validators/credentials_model.dart';
import 'package:annotations_app/src/utils/validators/credentials_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  final LoginController _loginController;

  const LoginScreen({super.key, required LoginController loginController})
    : _loginController = loginController;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: deviceSize.width * 0.02,
                vertical: deviceSize.height * 0.01,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sticky_note_2_outlined,
                    size: 96,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Annotations',
                      style: AppTextStyles.textBold24.copyWith(
                        color: cs.onPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                          onChanged: _credentialsModel.setPassword,
                          controller: _passwordController,
                          hintText: 'Senha',
                          validator: _credentialsValidator.byField(
                            _credentialsModel,
                            'password',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Observer(
                      builder: (_) {
                        return PrimaryButton(
                          text: 'Entrar',
                          isLoading: widget._loginController.isLoading,
                          disable: widget._loginController.isLoading,
                          onPressed: _tryLogin,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: MultiTextButton(
                      onPressed: () async => context.go(Routes.register),
                      children: [
                        Text(
                          'Não possui conta? ',
                          style: AppTextStyles.text14.copyWith(
                            color: cs.primary,
                          ),
                        ),
                        Text(
                          'Cadastrar',
                          style: AppTextStyles.textBold14.copyWith(
                            color: cs.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _tryLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final user = await widget._loginController.login(
      email: _emailController.text,
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
        message: widget._loginController.errorMessage ?? 'Falha no login',
        toastType: 'error',
      );
    }
  }
}
