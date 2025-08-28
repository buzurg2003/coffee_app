import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/added_items.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../pages/settings_page.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  int _selectedTab = 0;
  bool hasNewNotification = false; // Track if there's a new notification

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    AddedItems(),
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _checkForNewItemsOnStart();
    _listenForNewItems();
  }

  // Check stored timestamp on app start to determine if there's a new notification
  Future<void> _checkForNewItemsOnStart() async {
    final prefs = await SharedPreferences.getInstance();
    final lastItemTimestamp = prefs.getInt('lastItemTimestamp') ?? 0;

    final snapshot = await FirebaseFirestore.instance
        .collection('added_items')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final latestItemTimestamp = snapshot.docs.first['timestamp'];
      // Convert Firestore Timestamp to int
      final latestTimestampMillis = latestItemTimestamp.seconds * 1000 +
          latestItemTimestamp.millisecondsSinceEpoch % 1000;

      if (latestTimestampMillis > lastItemTimestamp) {
        setState(() {
          hasNewNotification = true;
        });
      }
    }
  }

  // Listen for real-time updates and update notification icon
  void _listenForNewItems() {
    FirebaseFirestore.instance
        .collection('added_items')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) async {
      if (snapshot.docChanges.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        final latestItemTimestamp = snapshot.docs.first['timestamp'];
        // Convert Firestore Timestamp to int
        final latestTimestampMillis = latestItemTimestamp.seconds * 1000 +
            latestItemTimestamp.millisecondsSinceEpoch % 1000;

        // Store the latest timestamp
        await prefs.setInt('lastItemTimestamp', latestTimestampMillis);

        setState(() {
          hasNewNotification =
              true; // Set notification indicator when a new item is added
        });
      }
    });
  }

  void onSelectedTab(int index) {
    if (_selectedTab == index) return;

    setState(() {
      _selectedTab = index;
    });
  }

  void _showNotificationsBottomSheet(BuildContext context) {
    setState(() {
      hasNewNotification =
          false; // Reset notification indicator when opening the sheet
    });

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('added_items')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'No notifications available.',
                  style: TextStyle(color: Colors.grey[400], fontSize: 16),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notifications',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 24,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      children: snapshot.data!.docs.map((doc) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            leading: Icon(
                              Icons.notifications,
                              color: Colors.orange,
                            ),
                            title: Text(
                              doc['name'] ?? 'No Title',
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              doc['description'] ?? '',
                              style: TextStyle(color: Colors.grey[300]),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Close',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _showNotificationsBottomSheet(context);
            },
            icon: Icon(
              hasNewNotification
                  ? Icons.notifications_on
                  : Icons
                      .notifications, // Change icon based on notification status
              color: Colors.orange,
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
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
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle),
                label: 'Added Items',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
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
