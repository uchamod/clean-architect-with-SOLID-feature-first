import 'package:clen_archetecture_bloc_app/core/constant/constants.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_colors.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_theme.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/widgets/auth_button.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/widgets/auth_form_field.dart';
import 'package:flutter/material.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isVisible = false;
  final _formKey = GlobalKey<FormState>();
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
                  AuthButton(buttonText: "Sing Up", onPressed: () {  },),
                  SizedBox(height: 12),
                  //register insted
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: AppTheme.lableTextTheme,
                      children: [
                        TextSpan(
                          text: "Sing In",
                          style: AppTheme.lableTextTheme.copyWith(
                            color: AppColorPallete.gradient1,
                          ),
                        ),
                      ],
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
