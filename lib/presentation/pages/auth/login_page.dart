import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_flutter/core/constants/app_constants.dart';
import 'package:fortnite_flutter/core/theme/fortnite_theme.dart';
import 'package:fortnite_flutter/core/utils/snackbar_helper.dart';
import 'package:fortnite_flutter/core/utils/validators.dart';
import 'package:fortnite_flutter/presentation/cubits/auth/auth_cubit.dart';
import 'package:fortnite_flutter/presentation/cubits/auth/auth_state.dart';
import 'package:fortnite_flutter/presentation/pages/auth/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            SnackbarHelper.showError(context, state.message);
          }
          if (state is AuthAuthenticated) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(AppConstants.imgFundo),
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  FortniteTheme.darkBackground,
                  FortniteTheme.primaryPurple.withAlpha(100),
                  FortniteTheme.primaryBlue.withAlpha(100),
                ],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo/Title
                      Text(
                        'FORTNITE',
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(
                              fontSize: 48,
                              shadows: FortniteTheme.neonShadow
                                  .map(
                                    (s) => Shadow(
                                      color: s.color,
                                      blurRadius: s.blurRadius,
                                    ),
                                  )
                                  .toList(),
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'SHOP',
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(color: FortniteTheme.primaryBlue),
                      ),
                      const SizedBox(height: 48),

                      // Login Form
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: FortniteTheme.cardBackground.withAlpha(230),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: FortniteTheme.neonShadow,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Text(
                                'Login',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 24),

                              // Email Field
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: Validators.email,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email_outlined),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Password Field
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                validator: Validators.password,
                                decoration: InputDecoration(
                                  labelText: 'Senha',
                                  prefixIcon: const Icon(Icons.lock_outlined),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Login Button
                              BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  final isLoading = state is AuthLoading;
                                  return SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: isLoading
                                          ? null
                                          : _handleLogin,
                                      child: isLoading
                                          ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Text('ENTRAR'),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 16),

                              // Register Link
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const RegisterPage(),
                                    ),
                                  );
                                },
                                child: const Text('Não tem conta? Cadastre-se'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
