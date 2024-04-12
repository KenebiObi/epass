import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class NumberPickerWidget extends StatefulWidget {
  NumberPickerWidget(
      {super.key, required this.mainValue, required this.executable});

  final int mainValue;
  final void Function(int newValue) executable;

  @override
  State<NumberPickerWidget> createState() => _NumberPickerWidgetState();
}

class _NumberPickerWidgetState extends State<NumberPickerWidget> {
  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Container(
      height: 70.0,
      decoration: isDarkMode
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Theme.of(context).colorScheme.secondary,
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Theme.of(context).colorScheme.primary,
            ),
      child: Center(
        child: NumberPicker(
          axis: Axis.horizontal,
          itemWidth: 50.0,
          selectedTextStyle: TextStyle(
            color: isDarkMode ? Colors.black : Colors.white,
            fontSize: 35.0,
          ),
          textStyle: TextStyle(
            color: isDarkMode ? Colors.black : Colors.grey[300],
            fontSize: 20.0,
          ),
          minValue: 0,
          maxValue: 20,
          value: widget.mainValue,
          onChanged: widget.executable,
        ),
      ),
    );
  }
}
