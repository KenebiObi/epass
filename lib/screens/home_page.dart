// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:epass/screens/generate_password_screen.dart';
// import 'package:epass/screens/auth_screens/auth_screen.dart';
// import 'package:epass/screens/save_password_screen.dart';

// final _firebase = FirebaseAuth.instance;

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   void logout() {
//     if (_firebase.currentUser != null) {
//       FirebaseAuth.instance.signOut();
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const AuthScreen(),
//         ),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const AuthScreen(),
//         ),
//       );
//     }
//   }

//   bool onTapBottomNavBarIcon = false;
//   int currentIndex = 0;
//   List<Widget> screens = [
//     const GeneratepasswordScreen(),
//     SavepasswordScreen(
//       saveDetails: null,
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // extendBody: true,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //   children: [
//             //     Row(
//             //       children: [
//             //         const SizedBox(width: 15.0),
//             //         CircleAvatar(
//             //           radius: 20.0,
//             //           child: Center(
//             //             child: _firebase.currentUser != null
//             //                 ? Text(
//             //                     "${_firebase.currentUser!.email}"[0],
//             //                     style: const TextStyle(fontSize: 20.0),
//             //                   )
//             //                 : const Icon(Icons.person_rounded),
//             //           ),
//             //         ),
//             //       ],
//             //     ),
//             //     Row(
//             //       children: [
//             //         IconButton(
//             //           onPressed: logout,
//             //           icon: const Icon(Icons.logout_rounded),
//             //         ),
//             //       ],
//             //     ),
//             //     // const SizedBox(width: 15.0),
//             //   ],
//             // ),
//             screens[currentIndex],
//           ],
//         ),
//       ),
//       // bottomNavigationBar: Padding(
//       //   padding: const EdgeInsets.only(
//       //     left: 60.0,
//       //     right: 60.0,
//       //     bottom: 20.0,
//       //     top: 10.0,
//       //   ),
//       //   child: GNav(
//       //     selectedIndex: currentIndex,
//       //     onTabChange: (int? newIndex) {
//       //       setState(() {
//       //         currentIndex = newIndex!;
//       //         onTapBottomNavBarIcon = !onTapBottomNavBarIcon;
//       //       });
//       //       print(currentIndex);
//       //       print(screens[currentIndex]);
//       //     },
//       //     backgroundColor: Colors.transparent,
//       //     tabBackgroundColor: Theme.of(context).colorScheme.primary,
//       //     padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
//       //     activeColor: Theme.of(context).colorScheme.background,
//       //     color: Theme.of(context).colorScheme.primary,
//       //     gap: 8.0,
//       //     tabs: [
//       //       GButton(
//       //         icon: onTapBottomNavBarIcon
//       //             ? Icons.settings_suggest_rounded
//       //             : Icons.settings_suggest_outlined,
//       //         text: "Generate",
//       //       ),
//       //       GButton(
//       //         icon: onTapBottomNavBarIcon
//       //             ? Icons.favorite_border_rounded
//       //             : Icons.favorite_rounded,
//       //         text: "Save",
//       //       ),
//       //     ],
//       //   ),
//       // ),
//       // bottomNavigationBar: Padding(
//       //   padding: const EdgeInsets.all(15.0),
//       //   child: ClipRRect(
//       //     borderRadius: BorderRadius.circular(20.0),
//       //     child: BottomNavigationBar(
//       //       elevation: 0,
//       //       // backgroundColor: Colors.grey[900],
//       //       backgroundColor: const Color.fromARGB(107, 0, 0, 0),
//       //       type: BottomNavigationBarType.fixed,
//       //       items: const [
//       //         BottomNavigationBarItem(
//       //           icon: Icon(
//       //             Icons.home_outlined,
//       //             color: Theme.of(context).colorScheme.background,
//       //           ),
//       //           label: "1",
//       //         ),
//       //         BottomNavigationBarItem(
//       //           icon: Icon(
//       //             Icons.menu,
//       //             color: Theme.of(context).colorScheme.background,
//       //           ),
//       //           label: "2",
//       //         ),
//       //         BottomNavigationBarItem(
//       //           icon: Icon(
//       //             Icons.contact_phone_outlined,
//       //             color: Theme.of(context).colorScheme.background,
//       //           ),
//       //           label: "3",
//       //         ),
//       //         BottomNavigationBarItem(
//       //           icon: Icon(
//       //             Icons.messenger_outline_outlined,
//       //             color: Theme.of(context).colorScheme.background,
//       //           ),
//       //           label: "4",
//       //         ),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }
