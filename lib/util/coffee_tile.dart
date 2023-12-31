import 'package:flutter/material.dart';

class CoffeeTile extends StatelessWidget {

  final String coffeeImagePath;
  final String coffeeName;
  final String coffeePrice;
  final String coffeeDescription;
  
  final VoidCallback onTap;

  CoffeeTile({
    required this.coffeeImagePath, 
    required this.coffeeName, 
    required this.coffeeDescription, 
    required this.coffeePrice, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        bottom: 5,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12),
          width: 190,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black54,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              // Coffee image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(coffeeImagePath)
              ),
          
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Coffee name
                    Text(
                      coffeeName,
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.orange
                      ),
                    ),            
                    // Coffee Description
                    Text(
                      coffeeDescription,
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              
              // price
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ $coffeePrice',
                      style: TextStyle(
                        fontSize: 17
                      ),
                    ),
                    InkWell(
                      onTap: () => showDialog(
                        context: context, 
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Item was added'),
                          content: const Text('AlertDialog description'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Icon(Icons.add),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
