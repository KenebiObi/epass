import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:epass/screens/generate_password_screen.dart';
import 'package:epass/screens/home_page.dart';

class OTP {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoginLoading = false;
  bool isOtpLoading = false;
  String actualCode = '';

  Future<void> getCodeWithPhoneNumber(
      BuildContext context, String phoneNumber) async {
    isLoginLoading = true;

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential auth) async {
        await _auth.signInWithCredential(auth).then(
          (value) {
            if (value != null && value.user != null) {
              print('Authentication successful');
              // onAuthenticationSuccessful(context, value);
            } else {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Invalid code/invalid authentication'),
                ),
              );
              print('Invalid code/invalid authentication');
            }
          },
        ).catchError(
          (error) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Something has gone wrong, please try later'),
              ),
            );
            print('Something has gone wrong, please try later');
          },
        );
      },
      verificationFailed: (FirebaseAuthException authException) {
        print('Error message: ${authException.message}');
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'The phone number format is incorrect. Please enter your number in E.164 format. [+][country code][number]',
              style: TextStyle(color: Theme.of(context).colorScheme.background),
            ),
          ),
        );
        print(
            'The phone number format is incorrect. Please enter your number in E.164 format. [+][country code][number]');
        isLoginLoading = false;
      },
      codeSent: (verificationId, forceResendingToken) {
        actualCode = verificationId;
        isLoginLoading = false;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        actualCode = verificationId;
      },
    );
  }

  Future<void> validateOtpAndLogin(BuildContext context, String smsCode) async {
    isOtpLoading = true;
    final AuthCredential _authCredential = PhoneAuthProvider.credential(
      verificationId: actualCode,
      smsCode: smsCode,
    );
    print(actualCode);

    await _auth.signInWithCredential(_authCredential).catchError((error) {
      isOtpLoading = false;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Wrong code ! Please enter the last code received.',
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
        ),
      );
    }).then((authResult) {
      if (authResult != null && authResult.user != null) {
        print('Authentication successful');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const GeneratepasswordScreen()),
        );
      }
    });
  }
}

class AuthResult {
  String uid;
  String email;
  String displayName;

  AuthResult(
      {required this.uid, required this.email, required this.displayName});
}
