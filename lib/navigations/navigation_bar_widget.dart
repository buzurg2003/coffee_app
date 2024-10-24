import 'package:coffee_app/pages/added_items.dart';
import 'package:coffee_app/pages/favorites_page.dart';
import 'package:coffee_app/pages/home_page.dart';
import 'package:coffee_app/pages/settings_page.dart';
import 'package:coffee_app/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {

  int _selectedTab = 0;

  static const List<Widget> _widgetOptions = <Widget> [
    HomePage(),
    AddedItems(),
    SettingsPage(),
  ];

  void onSelectedTab(int index) {
    if (_selectedTab == index) return;

    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        actions: <Widget> [
          IconButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => UserPage()),
              );
            }, 
            icon: Icon(
              Icons.account_circle,
              color: Colors.orange,
            ),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true, // set this to true
                builder: (_) {
                  return DraggableScrollableSheet(
                    expand: false,
                    builder: (_, controller) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          children: [
                            FilledButton.tonal(
                              onPressed: () {}, 
                              child: Text('Clean'),
                            ),
                            ListTile(
                              leading: Icon(Icons.add_alert_outlined),
                              title: Text('Title'),
                              subtitle: Text('Subtitle'),
                              onTap: () {},
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            }, 
            icon: Icon(
              Icons.add_alert,
              color: Colors.orange,
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.only(
            left: 10
          ),
          child: Text(
            _widgetOptions[_selectedTab].toString(),
            style: GoogleFonts.bebasNeue(
              color: Colors.orange,
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle),
                label: 'Added Items'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings'
              ),
            ],
            currentIndex: _selectedTab,
            selectedItemColor: Colors.orange,
            onTap: onSelectedTab,
          ),
        ),
      ),
      body: _widgetOptions[_selectedTab],
    );
  }
}
