import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyPasswordButton extends StatelessWidget {
  CopyPasswordButton({required this.clipBoardText, super.key});
  String clipBoardText;
  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Clipboard.setData(
            ClipboardData(text: clipBoardText),
          ).then(
            (_) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Password Copied!"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Ok",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
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
            Icons.content_copy,
            size: 30.0,
            color: isDarkMode
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
