import 'package:epass/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavepasswordButton extends StatelessWidget {
  SavepasswordButton({required this.onTap, super.key});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 70.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Icon(
            Icons.save,
            size: 40.0,
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
