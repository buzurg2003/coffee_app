import 'package:flutter/material.dart';

import 'package:coffee_app/navigations/navigation_bar_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Global list to hold added items
List<Map<String, String>> addedItems = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NavigationBarWidget(),
      theme: ThemeData.dark(),
    );
  }
}

// https://console.firebase.google.com/u/0/project/coffee-app-434da/firestore/databases/-default-/data/~2Fadded_items
