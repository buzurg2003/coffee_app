import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CappuccinoCoffee extends StatelessWidget {
  final String coffeeName;
  final String coffeeImagePath;
  final String coffeePrice;
  final String coffeeDescription;

  CappuccinoCoffee({
    required this.coffeeName,
    required this.coffeeImagePath,
    required this.coffeePrice,
    required this.coffeeDescription,
  });

  // Function to add coffee item to Firestore
  Future<void> addToFirestore() async {
    await FirebaseFirestore.instance.collection('added_items').add({
      'name': coffeeName,
      'price': coffeePrice,
      'description': coffeeDescription,
      'imagePath': coffeeImagePath,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    const String descriptionText = 
    'Cappuccino is a classic espresso-based coffee drink that originated in Italy. It is traditionally made with equal parts of espresso, steamed milk, and a layer of frothy milk foam on top. ';

    return Scaffold(
      appBar: AppBar(
        title: Text(coffeeName),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Coffee Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                  child: Image.asset(
                    coffeeImagePath,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover, // Ensure image covers the container
                  ),
                ),
              ),
              SizedBox(height: 20),
        
              // Coffee Name
              Text(
                coffeeName,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
        
              // Coffee Description Label
              Text(
                coffeeDescription,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: 20),
        
              // Description Text
              Text(
                descriptionText,    
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: 5),
        
              // Quantity Row
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Coffee Price
                  Text(
                    '\$$coffeePrice',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
        
              SizedBox(height: 20),
        
              // Add to Cart Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Heart/Favorite Icon
                  IconButton(
                    onPressed: () {
                      // Implement favorite functionality
                    },
                    icon: Icon(Icons.favorite_border, color: Colors.orange),
                  ),
        
                  // Add to Cart Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Button color
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        await addToFirestore();
                        // Show confirmation
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'The coffee item has been added to your cart.'
                            ),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
