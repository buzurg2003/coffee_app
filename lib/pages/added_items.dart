import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddedItems extends StatefulWidget {
  const AddedItems({super.key});

  @override
  State<AddedItems> createState() => _AddedItemsState();
}

class _AddedItemsState extends State<AddedItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('added_items').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                leading: Image.asset(doc['imagePath']),
                title: Text(doc['name']),
                subtitle: Text(doc['description']),
                trailing: Text(
                  '\$${
                    doc['price']
                  }',
                  style: TextStyle(
                    fontSize: 15
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
