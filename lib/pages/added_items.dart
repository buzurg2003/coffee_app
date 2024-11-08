import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddedItems extends StatefulWidget {
  const AddedItems({super.key});

  @override
  State<AddedItems> createState() => _AddedItemsState();
}

class _AddedItemsState extends State<AddedItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Set the desired background color
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('added_items')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 10.0), // Add margin between items
                decoration: BoxDecoration(
                  color: Colors.black54, // Background color of the ListTile
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10), // Add padding inside the ListTile
                  leading: Image.asset(doc['imagePath']),
                  title: Text(
                    doc['name'],
                    style: TextStyle(color: Colors.orange), // Set text color
                  ),
                  subtitle: Text(
                    doc['description'],
                    style: TextStyle(color: Colors.grey[300]), // Set subtitle color
                  ),
                  trailing: Text(
                    '\$${doc['price']}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white, // Set price color
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}