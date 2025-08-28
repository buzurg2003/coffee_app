import 'package:flutter/material.dart';

class MyAppleSignInButton extends StatelessWidget {
  final void Function()? onTap;

  MyAppleSignInButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Image.asset(
          'lib/assets/icons/apple.png',
          color: Colors.black,
          height: 35,
        ),
      ),
    );
  }
}
