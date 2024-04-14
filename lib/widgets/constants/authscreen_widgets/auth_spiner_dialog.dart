import 'dart:ui';

import 'package:flutter/material.dart';

class AuthSpinerDialog extends StatelessWidget {
  const AuthSpinerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          height: 250.0,
          width: 250.0,
          child: Center(
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget glassEffect() {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white10.withAlpha(80)),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.white.withAlpha(100),
          blurRadius: 10.0,
          spreadRadius: 0.0,
        ),
      ],
      color: Colors.white.withOpacity(0.2),
    ),
  );
}

// BackdropFilter(
//               filter: ImageFilter.blur(
//                 sigmaX: 15.0,
//                 sigmaY: 15.0,
//               ),
//               child: Container(
//                 width: 450,
//                 height: 250,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: const Color.fromARGB(0, 255, 255, 255).withAlpha(80),
//                   ),
//                   color: Colors.grey.withOpacity(0.1),
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(25),
//                   ),
//                 ),
//                 child: Center(
//                   child: CircularProgressIndicator(
//                     color: Theme.of(context).colorScheme.primary,
//                   ),
//                 ),
//               ),
//             ),