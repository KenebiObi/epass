import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart";
import "package:flutter/material.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";
import 'package:epass/screens/auth_screens/auth_screen.dart';
import "package:epass/screens/splash_screen.dart";
import 'package:epass/screens/hidden_drawer_menu_screen.dart';
import "package:epass/theme.dart";
import "package:provider/provider.dart";

import "firebase_options.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(PasswordApp());
  FlutterNativeSplash.remove();
}

class PasswordApp extends StatefulWidget {
  const PasswordApp({super.key});

  @override
  State<PasswordApp> createState() => _PasswordAppState();
}

class _PasswordAppState extends State<PasswordApp> {
  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
      child: ChangeNotifierProvider(
        create: (_) => ThemeManager(),
        child: Consumer<ThemeManager>(
          builder: (context, themeManager, _) {
            return MaterialApp(
              theme: themeManager.lightThemes,
              darkTheme: themeManager.darkThemes,
              themeMode: themeManager.themeMode == ThemeModeType.system
                  ? ThemeMode.system
                  : (themeManager.themeMode == ThemeModeType.dark
                      ? ThemeMode.dark
                      : ThemeMode.light),
              debugShowCheckedModeBanner: false,
              home: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const SplashScreen();
                  }
                  if (userSnapshot.hasData) {
                    return HiddenDrawer();
                  }
                  return const AuthScreen();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
