import 'package:epass/firebase_options.dart';
import 'package:epass/screens/auth_screens/auth_screen.dart';
import 'package:epass/screens/hidden_drawer_menu_screen.dart';
import 'package:epass/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:epass/theme.dart'; // Import your ThemeManager class here
import 'package:provider/provider.dart'; // Import Provider package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Wrap your PasswordApp with ChangeNotifierProvider for ThemeManager
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeManager(),
      child: PasswordApp(),
    ),
  );
}

class PasswordApp extends StatefulWidget {
  const PasswordApp({Key? key}) : super(key: key);

  @override
  State<PasswordApp> createState() => _PasswordAppState();
}

class _PasswordAppState extends State<PasswordApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Access the ThemeManager using Provider.of
      theme: Provider.of<ThemeManager>(context).lightThemes,
      darkTheme: Provider.of<ThemeManager>(context).darkThemes,
      themeMode: Provider.of<ThemeManager>(context).themeMode ==
              ThemeModeType.system
          ? ThemeMode.system
          : (Provider.of<ThemeManager>(context).themeMode == ThemeModeType.dark
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
  }
}
