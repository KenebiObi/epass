import 'package:epass/widgets/auth_spiner_dialog.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:epass/backend/google_auth_services.dart';
import 'package:epass/screens/hidden_drawer_menu_screen.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    super.key,
    required this.authService,
  });

  final GoogleAuthService authService;

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HiddenDrawer(),
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
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.maxFinite, 60.0),
        surfaceTintColor: Theme.of(context).colorScheme.background,
      ),
      onPressed: () async {
        showDialog(
          context: context,
          builder: (context) => const AuthSpinerDialog(),
        );

        User? user = await GoogleAuthService().signInWithGoogle(context);
        // final User? user = await authService.signInWithGoogle();
        if (user != null) {
          Navigator.of(context).pushReplacement(_createRoute());
        } else {
          // Handle sign-in cancellation or error
          // Show a message or take appropriate action
        }
      },
      icon: Image.asset(
        "assets/images/google.png",
        height: 30.0,
      ),
      label: const Text(
        "Sign In with google",
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }
}
