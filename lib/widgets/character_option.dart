import 'package:flutter/material.dart';

class CharacterOptionWidget extends StatefulWidget {
  const CharacterOptionWidget({
    required this.color,
    required this.icon,
    required this.chracterSelection,
    required this.onTap,
    super.key,
  });

  final Color color;
  final IconData icon;
  final String chracterSelection;
  final void Function() onTap;

  @override
  State<CharacterOptionWidget> createState() => _CharacterOptionWidgetState();
}

class _CharacterOptionWidgetState extends State<CharacterOptionWidget> {
  bool? value = false;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              height: constraints.maxWidth >= 255.0 ? 70.0 : 60.0,
              width: deviceWidth - 40.0,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          widget.icon,
                          size: 30.0,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          widget.chracterSelection,
                          softWrap: true,
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Checkbox(
                    value: value,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onChanged: (bool? newValue) {
                      widget.onTap();

                      setState(() {
                        value = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15.0),
          ],
        );
      },
    );
  }
}
