import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery/views/auth/components/sign_up_button.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/validators.dart';
import '../../../core/routes/app_routes.dart';
import '../../../features/users/domain/entities/user.dart';
import '../../../features/users/presentation/controller/user_controller.dart';
import '../../../features/users/presentation/providers/user_provider_provider.dart';
import 'already_have_accout.dart';
import '../../../core/themes/app_themes.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPasswordShown = false;

  void onPassShowClicked() {
    setState(() {
      isPasswordShown = !isPasswordShown;
    });
  }

  Future<void> onSignUp() async {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    final userProviderNotifier = ref.read(userProvider.notifier);
    final userController = UserController(userProviderNotifier);

    final newUser = User(
      id: 0,
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      password: _passwordController.text,
    );

    await userController.createUser(newUser);

    final userState = ref.read(userProvider);

    if (userState.error == null) {
      // sucesso
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário cadastrado com sucesso!')),
        );
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    } else {
      // erro
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(userState.error ?? 'Erro ao cadastrar.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.defaultTheme.copyWith(
        inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
      ),
      child: Container(
        margin: const EdgeInsets.all(AppDefaults.margin),
        padding: const EdgeInsets.all(AppDefaults.padding),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: AppDefaults.boxShadow,
          borderRadius: AppDefaults.borderRadius,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Name"),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                validator: Validators.requiredWithFieldName('Name').call,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AppDefaults.padding),
              const Text("Email"),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: Validators.email.call,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AppDefaults.padding),
              const Text("Phone Number"),
              const SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                textInputAction: TextInputAction.next,
                validator: Validators.required.call,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: AppDefaults.padding),
              const Text("Password"),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                validator: Validators.required.call,
                textInputAction: TextInputAction.done,
                obscureText: !isPasswordShown,
                onFieldSubmitted: (_) => onSignUp(),
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
              const SizedBox(height: AppDefaults.padding),
              SignUpButton(onPressed: onSignUp),
              const AlreadyHaveAnAccount(),
              const SizedBox(height: AppDefaults.padding),
            ],
          ),
        ),
      ),
    );
  }
}
