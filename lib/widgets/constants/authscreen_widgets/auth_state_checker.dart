import 'package:flutter/material.dart';

class AuthStateChecker extends StatelessWidget {
  const AuthStateChecker({
    super.key,
    required this.screen,
    required this.isSignInScreen,
  });
  final Widget screen;
  final bool isSignInScreen;

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
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
      return Flexible(
        child: constraints.maxWidth <= 315
            ? Column(
                children: [
                  Text(
                    isSignInScreen
                        ? "Already have an account?"
                        : "Are you new here?",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => screen,
                      //   ),
                      // );
                      Navigator.of(context).pushReplacement(_createRoute());
                    },
                    child: Text(
                      isSignInScreen ? "Login" : "Sign Up",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isSignInScreen
                        ? "Already have an account?"
                        : "Are you new here?",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => screen,
                      //   ),
                      // );
                      Navigator.of(context).pushReplacement(_createRoute());
                    },
                    child: Text(
                      isSignInScreen ? "Login" : "Sign Up",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
