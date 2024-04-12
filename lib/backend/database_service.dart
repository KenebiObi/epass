import 'dart:math';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epass/backend/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';

const String USER_DEATILS_COLLECTION_REF = "users";
final String keyString =
    'my32lengthsupersecretnooneknows1'; // Replace with your actual key
final String ivString = 'my16lengthsecre'; // Replace with your actual IV

class DataBaseServices {
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  late final CollectionReference _userDetailsRef;

  DataBaseServices() {
    _userDetailsRef = firebase
        .collection(USER_DEATILS_COLLECTION_REF)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("user_data")
        .withConverter<UserDetails>(
          fromFirestore: (snapshots, _) =>
              UserDetails.fromJson(snapshots.data()!),
          toFirestore: (userdetail, _) => userdetail.toJson(),
        );
  }

  String encryptPassword(String plainText) {
    final key = encrypt.Key.fromUtf8(keyString);
    final iv = encrypt.IV.fromUtf8(ivString);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  String decryptPassword(String encryptedText) {
    try {
      final key = encrypt.Key.fromUtf8(keyString);
      final iv = encrypt.IV.fromUtf8(ivString);

      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
      return decrypted;
    } catch (e) {
      print("Error decrypting password: $e");
      return ''; // Return empty string or handle the error accordingly
    }
  }

  Stream<QuerySnapshot> getUserDetails() {
    return _userDetailsRef.orderBy("createdOn", descending: true).snapshots();
  }

  void addUserDetails(UserDetails userDetail) async {
    final encryptedPassword = encryptPassword(userDetail.password);
    final userDetailsWithEncryptedPassword = userDetail.copyWith(
      password: encryptedPassword,
    );

    await _userDetailsRef.add(userDetailsWithEncryptedPassword);
  }

  void updateUserDetails(String userDetailId, UserDetails userDetail) async {
    try {
      // Check if the user provided a new password
      if (userDetail.password.isNotEmpty) {
        // Encrypt the new password
        final encryptedPassword = encryptPassword(userDetail.password);

        // Update the user details with the encrypted password
        userDetail = userDetail.copyWith(password: encryptedPassword);
      } else {
        // Cast existing user details to UserDetails type
        final existingUserDetailSnapshot =
            await _userDetailsRef.doc(userDetailId).get();
        final existingUserDetail =
            existingUserDetailSnapshot.data() as Map<String, dynamic>;
        final userDetails = UserDetails.fromJson(existingUserDetail);
        // Set the password to the existing encrypted password
        userDetail = userDetail.copyWith(password: userDetails.password);
      }

      // Update the user details in Firestore
      await _userDetailsRef.doc(userDetailId).update(userDetail.toJson());
    } catch (e) {
      print("Error updating user details: $e");
      // Handle the error accordingly
    }
  }

  void deleteUserDetails(String userDetailId) {
    _userDetailsRef.doc(userDetailId).delete();
  }
}
