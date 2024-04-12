import 'package:epass/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CopyPasswordButton extends StatelessWidget {
  CopyPasswordButton({required this.clipBoardText, super.key});
  final String clipBoardText;
  @override
  Widget build(BuildContext context) {
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
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Icon(
            Icons.content_copy,
            size: 30.0,
            color: Provider.of<ThemeManager>(context).themeMode ==
                    ThemeModeType.dark
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
