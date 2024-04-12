import 'package:flutter/material.dart';
import 'package:epass/screens/auth_screens/forgot_password_screen.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ForgotPasswordScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset(0.0, 0.0);
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        mainAxisAlignment: constraints.maxWidth <= 315
            ? MainAxisAlignment.center
            : MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.push(context, _createRoute()),
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
