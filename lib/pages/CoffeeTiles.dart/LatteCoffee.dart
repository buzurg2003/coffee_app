import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LatteCoffee extends StatefulWidget {
  const LatteCoffee({super.key});

  @override
  State<LatteCoffee> createState() => _LatteCoffeeState();
}

class _LatteCoffeeState extends State<LatteCoffee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.orange, 
        ),
        title: Text(
          'Latte',
          style: GoogleFonts.bebasNeue(
              color: Colors.orange,
              fontSize: 30,
            ),
        ),
      ),
    );
  }
}
