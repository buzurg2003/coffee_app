import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlackCoffee extends StatefulWidget {
  const BlackCoffee({super.key});

  @override
  State<BlackCoffee> createState() => _BlackCoffeeState();
}

class _BlackCoffeeState extends State<BlackCoffee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.orange, 
        ),
        title: Text(
          'Black',
          style: GoogleFonts.bebasNeue(
              color: Colors.orange,
              fontSize: 30,
            ),
        ),
      ),
    );
  }
}
