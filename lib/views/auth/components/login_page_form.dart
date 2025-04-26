import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/app_themes.dart';
import '../../../core/utils/validators.dart';
import '../../../features/users/presentation/controller/user_controller.dart';
import '../../../features/users/presentation/providers/user_provider_provider.dart';
import '../../../features/users/domain/entities/user.dart';
import 'login_button.dart';

class LoginPageForm extends ConsumerStatefulWidget {
  const LoginPageForm({super.key});

  @override
  ConsumerState<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends ConsumerState<LoginPageForm> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPasswordShown = false;

  void onPassShowClicked() {
    setState(() {
      isPasswordShown = !isPasswordShown;
    });
  }

  Future<void> onLogin() async {
    final bool isFormOkay = _key.currentState?.validate() ?? false;
    if (!isFormOkay) return;

    final userProviderNotifier = ref.read(userProvider.notifier);
    final userController = UserController(userProviderNotifier);

    final user = User(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      id: 0,
      name: 'no_name',
      phone: 'no_phone',
    );

    await userController.login(user);

    final userProviderState = ref.read(userProvider);

    if (userProviderState.currentUser != null) {
      Navigator.pushReplacementNamed(context, AppRoutes.entryPoint);
    } else {
      final errorMessage = userProviderState.error ?? 'Erro desconhecido ao fazer login.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.defaultTheme.copyWith(
        inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Phone Field
              const Text("Email"),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: Validators.email.call,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AppDefaults.padding),

              // Password Field
              const Text("Password"),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                validator: Validators.password.call,
                onFieldSubmitted: (_) => onLogin(),
                textInputAction: TextInputAction.done,
                obscureText: !isPasswordShown,
                decoration: InputDecoration(
                  suffixIcon: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: onPassShowClicked,
                      icon: SvgPicture.asset(
                        AppIcons.eye,
                        width: 24,
                      ),
                    ),
                  ),
                ),
              ),

              // Forget Password labelLarge
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgotPassword);
                  },
                  child: const Text('Forget Password?'),
                ),
              ),

              // Login labelLarge
              LoginButton(onPressed: onLogin),
            ],
          ),
        ),
      ),
    );
  }
}
