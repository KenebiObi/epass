import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundScreenDecor extends StatelessWidget {
  const BackgroundScreenDecor({
    super.key,
    required this.screen,
    required this.isNotAuthScreen,
  });

  final Widget screen;
  final bool isNotAuthScreen;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Positioned(
            top: -380.0,
            left: -210.0,
            child: Container(
              width: 580.0,
              height: 580.0,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -450.0,
            right: -250.0,
            child: Container(
              width: 600.0,
              height: 600.0,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          isNotAuthScreen
              ? Positioned.fill(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(20.0), // Adjust as needed
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 30.0,
                        sigmaY: 30.0,
                      ), // Adjust blur intensity
                      child: Container(
                        color: Colors
                            .transparent, // Transparent color for the glass effect
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          screen
        ],
      );
    });
  }
}
