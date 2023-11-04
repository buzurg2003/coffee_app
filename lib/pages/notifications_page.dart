import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.orange, 
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.bebasNeue(
              color: Colors.orange,
              fontSize: 30,
            ),
        ),
      ),
    );
  }
}
