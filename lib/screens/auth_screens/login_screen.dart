import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:epass/backend/google_auth_services.dart';
import 'package:epass/screens/hidden_drawer_menu_screen.dart';
import 'package:epass/screens/auth_screens/signup_screen.dart';
import 'package:epass/widgets/auth_spiner_dialog.dart';
import 'package:epass/widgets/background_screen_decor.dart';
import 'package:epass/widgets/constants/authscreen_widgets/auth_state_checker.dart';
import 'package:epass/widgets/constants/authscreen_widgets/email_textfield.dart';
import 'package:epass/widgets/constants/authscreen_widgets/google_signin_button.dart';
import 'package:epass/widgets/constants/authscreen_widgets/password_textfield.dart';
import 'package:epass/widgets/constants/authscreen_widgets/signup_login_button.dart';
import 'package:epass/widgets/forgot_password_button.dart';

final _firebase = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleAuthService authService = GoogleAuthService();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isAuthenticating = false;
  bool _isChanged = false;

  // Dispose the textfield data
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

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

  // Login user, navigate to home page and clear textfield
  Future login() async {
    setState(
      () {
        _isAuthenticating = true;
        if (_isAuthenticating) {
          showDialog(
            context: context,
            builder: (context) => const AuthSpinerDialog(),
          );
        }
      },
    );

    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await _firebase.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        print(userCredential);
        print("User created");
        Navigator.pop(context);

        Navigator.of(context).push(_createRoute());
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication failed.'),
          ),
        );
        Navigator.pop(context);
      }
    }
    _emailController.clear();
    _passwordController.clear();
    setState(() {
      _isAuthenticating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevent screen from resizing when keyboard appears
      body: LayoutBuilder(
        builder: (context, constraints) {
          return BackgroundScreenDecor(
            isNotAuthScreen: false,
            screen: SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    top: constraints.maxWidth <= 315 ? 20 : 50.0,
                    left: constraints.maxWidth <= 315 ? 20 : 50.0,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: "Lexend",
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 30.0),
                              const Text(
                                "Welcome Back",
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontFamily: "Lexend",
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              const Text(
                                "You've been missed!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  letterSpacing: 0.5,
                                  fontSize: 22.0,
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              // Email textfield
                              EmailTextfield(emialController: _emailController),
                              const SizedBox(height: 15.0),
                              // Password textfeild
                              PasswordTextfield(
                                passwordController: _passwordController,
                                isChanged: _isChanged,
                                isConfirmPassword: false,
                              ),
                              const SizedBox(height: 30.0),
                              SignUpLoginButton(
                                onPressed: login,
                                isSignUpScreen: false,
                              ),
                              const SizedBox(height: 15.0),
                              const ForgotPasswordButton(),
                              AuthStateChecker(
                                screen: SignUpScreen(),
                                isSignInScreen: false,
                              ),
                              const Text(
                                "Or",
                                style: TextStyle(
                                  fontSize: 25.0,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              GoogleSignInButton(authService: authService),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
