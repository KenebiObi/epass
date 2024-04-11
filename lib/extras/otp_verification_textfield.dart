import 'package:flutter/material.dart';

class OTPVerificationTextField extends StatelessWidget {
  const OTPVerificationTextField({
    super.key,
    required this.otpVerificationTextFieldController,
    required this.topLeft,
    required this.bottomLeft,
    required this.topRight,
    required this.bottomRight,
    required this.isLast,
  });
  final TextEditingController otpVerificationTextFieldController;
  final double topLeft;
  final double bottomLeft;
  final double topRight;
  final double bottomRight;
  final bool isLast;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 56.0,
          height: 83.0,
          child: TextFormField(
            controller: otpVerificationTextFieldController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a valid number";
              }
              return null;
            },
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            // obscureText: true,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Karla',
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: Colors.black,
            ),
            textInputAction:
                !isLast ? TextInputAction.next : TextInputAction.done,
            maxLength: 1,
            keyboardType: TextInputType.number,
            cursorWidth: 1.5,
            cursorColor: Theme.of(context).colorScheme.primary,
            decoration: InputDecoration(
              counterText: "",
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(topLeft),
                  bottomLeft: Radius.circular(bottomLeft),
                  topRight: Radius.circular(topRight),
                  bottomRight: Radius.circular(bottomRight),
                ),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(topLeft),
                  bottomLeft: Radius.circular(bottomLeft),
                  topRight: Radius.circular(topRight),
                  bottomRight: Radius.circular(bottomRight),
                ),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
