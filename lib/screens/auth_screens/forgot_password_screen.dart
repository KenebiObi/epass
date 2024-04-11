import 'package:epass/widgets/auth_spiner_dialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:epass/widgets/background_screen_decor.dart';
import 'package:epass/widgets/constants/authscreen_widgets/email_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _resetPassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (_isLoading) {
        showDialog(
          context: context,
          builder: (context) => const AuthSpinerDialog(),
        );
      }
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      // Show success message or navigate to login screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent. Please check your email.'),
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Failed to send password reset email. Please try again.'),
        ),
      );
      Navigator.pop(context);
    }

    setState(() {
      _isLoading = false;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundScreenDecor(
        isNotAuthScreen: false,
        screen: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 50.0,
                left: 10.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 30.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    const SizedBox(
                      width: 150.0,
                      child: Text(
                        "Forgot Password",
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontFamily: "Lexend",
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EmailTextfield(emialController: _emailController),
                    const SizedBox(height: 20.0),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.grey[600],
                              surfaceTintColor:
                                  Theme.of(context).colorScheme.background,
                              elevation: 10.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              minimumSize: const Size(double.infinity, 60.0),
                            ),
                            onPressed: _isLoading ? null : _resetPassword,
                            child: Text(
                              'Reset Password',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
