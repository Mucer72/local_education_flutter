import 'package:flutter/material.dart';
import 'package:local_education_app/api/auth_api.dart';
import 'package:local_education_app/screens/signup/widgets/login_suggestion.dart';
import 'package:local_education_app/screens/signup/widgets/signup_button.dart';
import 'package:local_education_app/services/email/email_validator.dart';
import 'package:local_education_app/widgets/auth_text_field.dart';
import 'package:local_education_app/widgets/header.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? _phoneErrorText;
  String? _passwordErrorText;
  String? _usernameErrorText;
  String? _emailErrorText;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header
              appHeader("SignUp", context),

              // Fields
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    //Phone
                    AuthInputField(
                      onChanged: (value) {
                        setState(() {
                          _phoneErrorText =
                              value.isEmpty ? 'Phone number is required' : null;
                        });
                      },
                      hintText: "Your phone number",
                      controller: _phoneController,
                      errorText: _phoneErrorText,
                    ),

                    // Username
                    AuthInputField(
                      onChanged: (value) {
                        setState(() {
                          _usernameErrorText =
                              value.isEmpty ? 'Username is required' : null;
                        });
                      },
                      hintText: 'Username',
                      errorText: _usernameErrorText,
                      controller: _usernameController,
                    ),

                    // Email
                    AuthInputField(
                      onChanged: (value) {
                        setState(() {
                          _emailErrorText = value.isEmpty
                              ? 'Email is required'
                              : EmailValidator.isValid(value)
                                  ? null
                                  : 'Invalid Email';
                        });
                      },
                      hintText: 'Email',
                      errorText: _emailErrorText,
                      controller: _emailController,
                    ),
                    // Password
                    AuthPasswordInputField(
                        controller: _passwordController,
                        errorText: _passwordErrorText,
                        onChanged: (value) {
                          setState(() {
                            _passwordErrorText =
                                value.isEmpty ? 'Email is required' : null;
                          });
                        })
                  ],
                ),
              ),

              // Button
              signUpButton(context, handleSignup),

              // Suggestion

              const LoginSuggestion(),
            ],
          ),
        ),
      ),
    );
  }
  void handleSignup() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _emailErrorText = 
            _emailController.text.isEmpty ? "email is required" : null;
        _phoneErrorText = 
            _phoneController.text.isEmpty ? "phone number is required" : null;
        _usernameErrorText =
            _usernameController.text.isEmpty ? "Username is required" : null;
        _passwordErrorText =
            _passwordController.text.isEmpty ? "Password is required" : null;
      });
    } else {
      final String username = _usernameController.text;
      final String password = _passwordController.text;
      final String phone =_phoneController.text;
      final String email = _emailController.text;
      final int result = await authRegister(phone, username, email, password);
      // if (!mounted) return;
      if (result == 200 && mounted) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: "Signup successfully",
          ),
          displayDuration: const Duration(seconds: 1),
        );
      } else if (result == 400 && mounted) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(message: "error occurs!"),
        );
      }
    }
  }
}
