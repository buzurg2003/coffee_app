import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CappuccinoCoffee extends StatefulWidget {
  const CappuccinoCoffee({super.key});

  @override
  State<CappuccinoCoffee> createState() => _CappuccinoCoffeeState();
}

class _CappuccinoCoffeeState extends State<CappuccinoCoffee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.orange, 
        ),
        title: Text(
          'Cappuccino',
          style: GoogleFonts.bebasNeue(
              color: Colors.orange,
              fontSize: 30,
            ),
        ),
      ),
    );
  }
}
