import 'package:flutter/material.dart';

class SignUpLoginButton extends StatelessWidget {
  const SignUpLoginButton({
    super.key,
    required this.onPressed,
    required this.isSignUpScreen,
  });
  final void Function() onPressed;
  final bool isSignUpScreen;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.grey[600],
        surfaceTintColor: Theme.of(context).colorScheme.background,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        minimumSize: const Size(double.infinity, 60.0),
      ),
      onPressed: onPressed,
      child: Text(
        isSignUpScreen ? "Sign Up" : "Login",
        style: const TextStyle(
          fontSize: 20.0,
          fontFamily: "Karla",
        ),
      ),
    );
  }
}
