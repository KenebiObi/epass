import 'package:flutter/material.dart';

class SavepasswordButton extends StatelessWidget {
  SavepasswordButton({required this.onTap, super.key});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 70.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDarkMode
                ? Theme.of(context).primaryColorLight
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Icon(
            Icons.save,
            size: 40.0,
            color: isDarkMode
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
