import 'dart:async';

import 'package:epass/widgets/constants/authscreen_widgets/auth_spiner_dialog.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:epass/backend/google_auth_services.dart';
import 'package:epass/screens/hidden_drawer_menu_screen.dart';

class GoogleSignInButton extends StatefulWidget {
  GoogleSignInButton({
    super.key,
    required this.authService,
  });

  final GoogleAuthService authService;

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  // late Timer _timer;

  // bool _showDialog = false;

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

  // void _startTimer() {
  //   _timer = Timer(Duration(seconds: 10), () {
  //     if (_showDialog) {
  //       Navigator.of(context).pop(); // Close the dialog after 10 seconds
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.maxFinite, 60.0),
          surfaceTintColor: Theme.of(context).colorScheme.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          shadowColor: Colors.grey[600],
          elevation: 10.0,
        ),
        onPressed: () async {
          // _showDialog = true;

          // Show dialog
          showDialog(
            context: context,
            builder: (context) => const AuthSpinerDialog(),
          );

          // _startTimer(); // Start the timer
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
    });
  }
}
