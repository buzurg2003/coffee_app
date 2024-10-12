import 'package:coffee_app/pages/CoffeeTiles.dart/BlackCoffee.dart';
import 'package:coffee_app/pages/CoffeeTiles.dart/CappuccinoCoffee.dart';
import 'package:coffee_app/pages/CoffeeTiles.dart/LatteCoffee.dart';
import 'package:coffee_app/pages/CoffeeTiles.dart/Tea.dart';
import 'package:coffee_app/util/coffee_tile.dart';
import 'package:coffee_app/util/coffee_type.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // list of coffee types
  final List coffeeType = [
    [
      'All', true
    ],
    [
      'Black', false
    ],
    [
      'Cappuccino', false
    ],
    [
      'Latte', false
    ],
    [
      'Tea', false
    ],
  ];

  // user tapped on coffee types
  void coffeeTypeSelected(int index) {
    setState(() {

      for(int i = 0; i < coffeeType.length; i++ ) {
        coffeeType[i][1] = false;
      }

      coffeeType[index][1] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Find the best coffee for you
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
            ),
            child: Text(
              'Find the best coffee for you',
              style: GoogleFonts.bebasNeue(
                fontSize: 60,
                color: Colors.orange
              ),
            ),
          ),
          
          SizedBox(height: 5,),
    
          // SearchBar
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Find your coffee...',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade600
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          
          SizedBox(height: 20,),
    
          // horizontal listView of coffee types
          Container(
            height: 50,
            padding: EdgeInsets.only(right: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: coffeeType.length,
              itemBuilder: (context, index) {
              return CoffeeType(
                coffeeType: coffeeType[index][0], 
                isSelected: coffeeType[index][1], 
                onTap: () {
                  coffeeTypeSelected(index);
                }
              );
            })
          ),
    
          SizedBox(height: 20,),
    
          // horizontal listView of coffee tiles
          SizedBox(
            height: 300,  // Adjust this height as per your design
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CoffeeTile(
                  coffeeName: 'Black',
                  coffeeImagePath: 'lib/images/black.png', 
                  coffeePrice: '4.20', 
                  coffeeDescription: 'With sugar', 
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => BlackCoffee()),
                    );
                  } 
                ),
                CoffeeTile(
                  coffeeName: 'Cappuccino',
                  coffeeImagePath: 'lib/images/cappuccino.png', 
                  coffeePrice: '4.20', 
                  coffeeDescription: 'With milk', 
                  onTap: () { 
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => CappuccinoCoffee()),
                    );
                  }, 
                ),
                CoffeeTile(
                  coffeeName: 'Latte',
                  coffeeImagePath: 'lib/images/latte.png', 
                  coffeePrice: '4.20', 
                  coffeeDescription: 'With almond milk', 
                  onTap: () { 
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => LatteCoffee()),
                    );
                  }, 
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 30
                  ),
                  child: CoffeeTile(
                    coffeeName: 'Tea',
                    coffeeImagePath: 'lib/images/tea.png', 
                    coffeePrice: '4.20', 
                    coffeeDescription: 'With lemon', 
                    onTap: () { 
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => Tea()),
                      );
                    }, 
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
