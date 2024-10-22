import 'package:flutter/material.dart';

class Tea extends StatelessWidget {
  final String coffeeName;
  final String coffeeImagePath;
  final String coffeePrice;
  final String coffeeDescription;

  Tea({
    required this.coffeeName,
    required this.coffeeImagePath,
    required this.coffeePrice,
    required this.coffeeDescription,
  });

  @override
  Widget build(BuildContext context) {
    const String descriptionText = 'Tea is a versatile beverage made by steeping cured or fresh tea leaves in hot water. It comes in various types, including black, green, white, oolong, and herbal, each offering distinct flavors and aromas.';

    return Scaffold(
      backgroundColor: Colors.black87, // Dark background
      appBar: AppBar(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Quantity Selector
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Implement decrement functionality
                        },
                        icon: Icon(Icons.remove, color: Colors.orange),
                      ),
                      Text(
                        '2', // You can replace this with a variable to control quantity
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          // Implement increment functionality
                        },
                        icon: Icon(Icons.add, color: Colors.orange),
                      ),
                    ],
                  ),
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
                      onPressed: () {
                        // Implement add to cart functionality
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
