import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:epass/backend/google_auth_services.dart';
import 'package:epass/screens/auth_screens/login_screen.dart';
import 'package:epass/screens/hidden_drawer_menu_screen.dart';
import 'package:epass/widgets/auth_spiner_dialog.dart';
import 'package:epass/widgets/background_screen_decor.dart';
import 'package:epass/widgets/constants/authscreen_widgets/auth_state_checker.dart';
import 'package:epass/widgets/constants/authscreen_widgets/email_textfield.dart';
import 'package:epass/widgets/constants/authscreen_widgets/google_signin_button.dart';
import 'package:epass/widgets/constants/authscreen_widgets/password_textfield.dart';
import 'package:epass/widgets/constants/authscreen_widgets/signup_login_button.dart';

final _firebase = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GoogleAuthService authService = GoogleAuthService();

  final TextEditingController _EmailTextfield = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isAuthenticating = false;
  bool _isChanged = false;
  bool _doNotMatch = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _EmailTextfield.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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

  Future signUp() async {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      if (_formKey.currentState!.validate()) {
        setState(
          () {
            _isAuthenticating = true;
            _doNotMatch = false;
            if (_isAuthenticating) {
              showDialog(
                context: context,
                builder: (context) => const AuthSpinerDialog(),
              );
            }
          },
        );

        try {
          UserCredential userCredential =
              await _firebase.createUserWithEmailAndPassword(
            email: _EmailTextfield.text.trim(),
            password: _passwordController.text.trim(),
          );
          print(userCredential);
          print("User created");
          Navigator.pop(context);
          Navigator.of(context).push(_createRoute());
          print("NIce");
        } on FirebaseAuthException catch (error) {
          print(error);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message ?? 'Authentication failed.'),
            ),
          );
          Navigator.pop(context);
        }
        _EmailTextfield.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
        setState(() {
          _isAuthenticating = false;
          // Navigator.pop(context);
        });
      }
    } else {
      setState(() {
        _doNotMatch = true;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevent screen from resizing when keyboard appears
      body: LayoutBuilder(builder: (context, constraints) {
        return BackgroundScreenDecor(
          isNotAuthScreen: false,
          screen: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: constraints.maxHeight <= 820
                      ? constraints.maxHeight * 0.05
                      : constraints.maxWidth * 0.10,
                  left: constraints.maxHeight <= 820
                      ? constraints.maxHeight * 0.05
                      : constraints.maxWidth * 0.10,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: constraints.maxWidth > 423
                          ? 30.0
                          : constraints.maxWidth * 0.07,
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
                              "Hello There",
                              style: TextStyle(
                                fontSize: 30.0,
                                fontFamily: "Lexend",
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w800,
                                // color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            const Text(
                              "Register to get started",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                letterSpacing: 0.5,
                                fontSize: 22.0,
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            // Email textfield
                            EmailTextfield(emialController: _EmailTextfield),
                            const SizedBox(height: 15.0),
                            // Password textfeild
                            PasswordTextfield(
                              passwordController: _passwordController,
                              isChanged: _isChanged,
                              isConfirmPassword: false,
                            ),
                            const SizedBox(height: 15.0),

                            PasswordTextfield(
                              passwordController: _confirmPasswordController,
                              isChanged: _isChanged,
                              isConfirmPassword: true,
                            ),
                            const SizedBox(height: 30.0),
                            SignUpLoginButton(
                              onPressed: signUp,
                              isSignUpScreen: true,
                            ),

                            _doNotMatch
                                ? const Column(
                                    children: [
                                      SizedBox(height: 15.0),
                                      Text(
                                        "Passwords do  not match",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 15.0),

                            AuthStateChecker(
                              screen: LoginScreen(),
                              isSignInScreen: true,
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
      }),
    );
  }
}
