import 'package:flutter/material.dart';

class PasswordTextfield extends StatefulWidget {
  PasswordTextfield({
    super.key,
    required this.passwordController,
    required this.isChanged,
    required this.isConfirmPassword,
  });

  final TextEditingController passwordController;
  bool isChanged;
  final bool isConfirmPassword;

  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: TextFormField(
          textInputAction: TextInputAction.next,
          controller: widget.passwordController,
          validator: (value) {
            if (value == null || value.isEmpty || value.trim().length < 6) {
              return "Please enter a password containing more than 6 characters";
            }
            return null;
          },
          keyboardType: TextInputType.visiblePassword,
          obscureText: !widget.isChanged ? true : false,
          style: const TextStyle(
            fontFamily: "Karla",
            fontSize: 18.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            labelText:
                widget.isConfirmPassword ? "Confirm password" : "Password",
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontFamily: "Karla",
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  widget.isChanged = !widget.isChanged;
                });
              },
              icon: Icon(
                widget.isChanged ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[700],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
