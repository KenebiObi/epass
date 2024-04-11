import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'otp_verification_textfield.dart';

class OTPVerificationTextfields extends StatelessWidget {
  const OTPVerificationTextfields({
    super.key,
    required this.OTPVerificationTextFieldController1,
    required this.OTPVerificationTextFieldController2,
    required this.OTPVerificationTextFieldController3,
    required this.OTPVerificationTextFieldController4,
    required this.OTPVerificationTextFieldController5,
    required this.OTPVerificationTextFieldController6,
  });

  final TextEditingController OTPVerificationTextFieldController1;
  final TextEditingController OTPVerificationTextFieldController2;
  final TextEditingController OTPVerificationTextFieldController3;
  final TextEditingController OTPVerificationTextFieldController4;
  final TextEditingController OTPVerificationTextFieldController5;
  final TextEditingController OTPVerificationTextFieldController6;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OTPVerificationTextField(
          otpVerificationTextFieldController:
              OTPVerificationTextFieldController1,
          topLeft: 24.0,
          bottomLeft: 24.0,
          topRight: 0.0,
          bottomRight: 0.0,
          isLast: false,
        ),
        OTPVerificationTextField(
          otpVerificationTextFieldController:
              OTPVerificationTextFieldController2,
          topLeft: 0.0,
          bottomLeft: 0.0,
          topRight: 0.0,
          bottomRight: 0.0,
          isLast: false,
        ),
        OTPVerificationTextField(
          otpVerificationTextFieldController:
              OTPVerificationTextFieldController3,
          topLeft: 0.0,
          bottomLeft: 0.0,
          topRight: 0.0,
          bottomRight: 0.0,
          isLast: false,
        ),
        OTPVerificationTextField(
          otpVerificationTextFieldController:
              OTPVerificationTextFieldController4,
          topLeft: 0.0,
          bottomLeft: 0.0,
          topRight: 0.0,
          bottomRight: 0.0,
          isLast: false,
        ),
        OTPVerificationTextField(
          otpVerificationTextFieldController:
              OTPVerificationTextFieldController5,
          topLeft: 0.0,
          bottomLeft: 0.0,
          topRight: 0.0,
          bottomRight: 0.0,
          isLast: false,
        ),
        OTPVerificationTextField(
          otpVerificationTextFieldController:
              OTPVerificationTextFieldController6,
          topLeft: 0.0,
          bottomLeft: 0.0,
          topRight: 24.0,
          bottomRight: 24.0,
          isLast: false,
        ),
      ],
    );
  }
}
