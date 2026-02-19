import 'package:clen_archetecture_bloc_app/core/constant/constants.dart';
import 'package:clen_archetecture_bloc_app/core/constant/size_extensions.dart';
import 'package:clen_archetecture_bloc_app/core/routes/route_names.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_colors.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_theme.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/widgets/auth_button.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/widgets/auth_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isVisible = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.horizontalPadding,
        ),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("User Registered Successfully")),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: context.screenHeight * 0.3),
                  Text(
                    "Register",
                    style: AppTheme.titleTextTheme.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 24),
                  //login form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //enter name
                        AuthFormField(
                          controller: _nameController,
                          hintText: "Username",

                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(height: 16),
                        //enter email
                        AuthFormField(
                          controller: _emailController,
                          hintText: "Email",

                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 16),
                        //enter password
                        AuthFormField(
                          controller: _passwordController,
                          hintText: "Password",

                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.visiblePassword,
                        ),
                        SizedBox(height: 48),
                        // sing up button
                        AuthButton(
                          buttonText: "Register",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                AuthSignUp(
                                  name: _nameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 12),
                        //register insted
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).goNamed(RouterNames.login);
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Already have an account? ",
                              style: AppTheme.lableTextTheme,
                              children: [
                                TextSpan(
                                  text: "Sign In",
                                  style: AppTheme.lableTextTheme.copyWith(
                                    color: AppColorPallete.gradient1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
