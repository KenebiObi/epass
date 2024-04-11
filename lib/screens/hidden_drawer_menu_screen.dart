import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:epass/screens/auth_screens/auth_screen.dart';
import 'package:epass/screens/generate_password_screen.dart';
import 'package:epass/screens/save_password_screen.dart';
import 'package:epass/theme.dart';
import 'package:provider/provider.dart';

final _firebase = FirebaseAuth.instance;

class HiddenDrawer extends StatefulWidget {
  HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];
  List<ScreenHiddenDrawer> getPages(double? fontSize, double? smallFontSize) {
    return _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Generate Passwords",
          colorLineSelected: Colors.white,
          baseStyle: TextStyle(
            fontSize: smallFontSize,
            fontFamily: "Karla",
            color: Colors.white,
          ),
          selectedStyle: TextStyle(
            fontSize: fontSize,
            fontFamily: "Karla",
          ),
        ),
        const GeneratepasswordScreen(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Save Passwords",
          colorLineSelected: Colors.white,
          baseStyle: TextStyle(
            fontSize: smallFontSize,
            fontFamily: "Karla",
            color: Colors.white,
          ),
          selectedStyle: TextStyle(
            fontSize: fontSize,
            fontFamily: "Karla",
          ),
        ),
        SavepasswordScreen(
          saveDetails: null,
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    getPages(null, null);
  }

  void logout() {
    if (_firebase.currentUser != null) {
      FirebaseAuth.instance.signOut();
      GoogleSignIn().signOut();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    // final themeManager = Provider.of<ThemeManager>(context, listen: false);
    return LayoutBuilder(builder: (context, constraints) {
      return HiddenDrawerMenu(
        styleAutoTittleName: TextStyle(
          fontSize: constraints.maxWidth <= 370 ? 17.0 : 20.0,
        ),
        elevationAppBar: 0,
        contentCornerRadius: 20.0,
        slidePercent: 65.0,
        withShadow: true,
        boxShadow: [
          isDarkMode
              ? BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .background
                      .withOpacity(0.7), // Shadow color
                  spreadRadius: 5.0, // Spread radius
                  blurRadius: 60.0, // Blur radius
                  offset: const Offset(-15.0, 20.0), // Offset
                )
              : const BoxShadow(color: Colors.transparent),
        ],
        screens: getPages(
          constraints.maxWidth <= 371 ? 18.0 : 20.0,
          constraints.maxWidth <= 371 ? 16.0 : 18.0,
        ),
        backgroundColorMenu: Theme.of(context).colorScheme.primary,
        initPositionSelected: 0,
        actionsAppBar: [
          IconButton(
            onPressed: () {
              setState(
                () {
                  final themeManager =
                      Provider.of<ThemeManager>(context, listen: false);
                  themeManager.toggleTheme();
                },
              );
            },
            icon: Icon(
              Provider.of<ThemeManager>(context).themeMode == ThemeModeType.dark
                  ? Icons.wb_sunny
                  : Icons.dark_mode,
              color: Provider.of<ThemeManager>(context).themeMode ==
                      ThemeModeType.dark
                  ? Colors.yellow[200]
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      );
    });
  }
}
