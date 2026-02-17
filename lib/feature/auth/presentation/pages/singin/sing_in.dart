import 'package:clen_archetecture_bloc_app/core/constant/constants.dart';
import 'package:clen_archetecture_bloc_app/core/routes/route_names.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_colors.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_theme.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/widgets/auth_button.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/widgets/auth_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SingInPage extends StatefulWidget {
  const SingInPage({super.key});

  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Sing Up", style: AppTheme.titleTextTheme),
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
                    buttonText: "Sing Up",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthSingUp(
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
                            text: "Sing Up",
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
      ),
    );
  }
}
