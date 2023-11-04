import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tea extends StatefulWidget {
  const Tea({super.key});

  @override
  State<Tea> createState() => _TeaState();
}

class _TeaState extends State<Tea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.orange, 
        ),
        title: Text(
          'Tea',
          style: GoogleFonts.bebasNeue(
              color: Colors.orange,
              fontSize: 30,
            ),
        ),
      ),
    );
  }
}
