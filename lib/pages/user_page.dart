import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.orange, 
        ),
        title: Text(
          'User',
          style: GoogleFonts.bebasNeue(
              color: Colors.orange,
              fontSize: 30,
            ),
        ),
      ),
    );
  }
}
