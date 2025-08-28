import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    super.key,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isObscured = false;

  @override
  void initState() {
    super.initState();
    isObscured =
        widget.obscureText; // Initialize with the provided obscureText value
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: isObscured, // Use state variable to handle visibility
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black.withOpacity(0.5),

        // border when unselected
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
          ),
          borderRadius: BorderRadius.circular(13),
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        suffixIcon: widget
                .obscureText // Show visibility toggle only if it's a password field
            ? IconButton(
                icon: Icon(
                  isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
              )
            : null,
      ),
      keyboardType: widget.obscureText
          ? TextInputType.text
          : TextInputType
              .emailAddress, // Adapt keyboard type for email/password
    );
  }
}
