import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPNumberTextField extends StatefulWidget {
  OTPNumberTextField({
    super.key,
    required this.otpNumberController,
    required this.otpCountryCodeController,
  });

  final TextEditingController otpNumberController;
  final TextEditingController otpCountryCodeController;
  @override
  State<OTPNumberTextField> createState() => _OTPNumberTextFieldState();
}

class _OTPNumberTextFieldState extends State<OTPNumberTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100.0,
          height: 83.0,
          child: TextFormField(
            controller: widget.otpCountryCodeController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a valid country code";
              }
              return null;
            },
            cursorColor: Theme.of(context).colorScheme.primary,
            style: const TextStyle(
              fontFamily: 'Karla',
              color: Colors.black,
            ),
            textInputAction: TextInputAction.next,
            maxLength: 3,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              counterText: "",
              prefixIcon: const Icon(
                CupertinoIcons.add,
              ),
              prefixIconColor: Colors.black,
              labelText: "Country Code",
              labelStyle: const TextStyle(
                color: Color.fromRGBO(172, 172, 172, 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  bottomLeft: Radius.circular(24.0),
                ),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  bottomLeft: Radius.circular(24.0),
                ),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 5.0),
        Expanded(
          child: SizedBox(
            height: 83.0,
            child: TextFormField(
              controller: widget.otpNumberController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a valid number";
                }
                return null;
              },
              cursorColor: Theme.of(context).colorScheme.primary,
              style: const TextStyle(
                fontFamily: 'Karla',
                color: Colors.black,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  CupertinoIcons.device_phone_portrait,
                ),
                prefixIconColor: Colors.black,
                labelText: "Phone Number",
                labelStyle: const TextStyle(
                  color: Color.fromRGBO(172, 172, 172, 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(24.0),
                    bottomRight: Radius.circular(24.0),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(24.0),
                    bottomRight: Radius.circular(24.0),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
