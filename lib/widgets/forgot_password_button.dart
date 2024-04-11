import 'package:flutter/material.dart';
import 'package:epass/screens/auth_screens/forgot_password_screen.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        mainAxisAlignment: constraints.maxWidth <= 315
            ? MainAxisAlignment.center
            : MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ForgotPasswordScreen(),
              ),
            ),
            child: const Text(
              "Forgot Password?",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      );
    });
  }
}
