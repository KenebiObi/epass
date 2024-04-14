// import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleAuthService {
//   signInWithGoogle() async {
//     final _googleSignIn = GoogleSignIn();
//     await _googleSignIn.signOut();
//     final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
//     final GoogleSignInAuthentication gAuth = await gUser!.authentication;
//     final credential = GoogleAuthProvider.credential(
//       accessToken: gAuth.accessToken,
//       idToken: gAuth.idToken,
//     );
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  Future<User?> signInWithGoogle(context) async {
    try {
      final _googleSignIn = GoogleSignIn(
        clientId:
            "908984739654-g4f0ud9ahdhfcpqeig08u7e10lar6i0l.apps.googleusercontent.com",
      );
      await _googleSignIn.signOut();

      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
      if (gUser == null) {
        // User cancelled sign-in
        return null;
      }
      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      final authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final uniqueTag1 = UniqueKey(); // Generate unique tag

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Signed in successfully as ${FirebaseAuth.instance.currentUser!.email}.',
          ),
          key: uniqueTag1,
        ),
      );
      Navigator.pop(context);
      return authResult.user;
    } on FirebaseAuthException catch (error) {
      print("Error signing in with google: $error");
      final uniqueTag2 = UniqueKey(); // Generate unique tag

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error signing in with google: ${error.message}"),
          key: uniqueTag2,
        ),
      );
      Navigator.pop(context);
      return null;
    }
  }
}
