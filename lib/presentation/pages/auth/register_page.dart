import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_flutter/core/theme/fortnite_theme.dart';
import 'package:fortnite_flutter/core/utils/snackbar_helper.dart';
import 'package:fortnite_flutter/core/utils/validators.dart';
import 'package:fortnite_flutter/presentation/cubits/auth/auth_cubit.dart';
import 'package:fortnite_flutter/presentation/cubits/auth/auth_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            SnackbarHelper.showError(context, state.message);
          } else if (state is AuthAuthenticated) {
            Navigator.of(context).pop();
          }
        },
        child: Container(
          decoration: BoxDecoration(
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
                      'CRIAR CONTA',
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
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
                    const SizedBox(height: 48),

                    // Register Form
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
                            // Name Field
                            TextFormField(
                              controller: _nameController,
                              validator: Validators.name,
                              decoration: const InputDecoration(
                                labelText: 'Nome',
                                prefixIcon: Icon(Icons.person_outlined),
                              ),
                            ),
                            const SizedBox(height: 16),

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
                            const SizedBox(height: 16),

                            // Confirm Password Field
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: _obscureConfirmPassword,
                              validator: (value) => Validators.confirmPassword(
                                value,
                                _passwordController.text,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Confirmar Senha',
                                prefixIcon: const Icon(Icons.lock_outlined),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirmPassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureConfirmPassword =
                                          !_obscureConfirmPassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Register Button
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                final isLoading = state is AuthLoading;
                                return SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: isLoading
                                        ? null
                                        : _handleRegister,
                                    child: isLoading
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Text('CADASTRAR'),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 16),

                            // Back to Login Link
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Já tem conta? Faça login'),
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
        ),
      ),
    );
  }
}
