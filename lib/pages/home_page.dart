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
  final TextEditingController searchController = TextEditingController();

  // List of coffee types
  final List coffeeType = [
    ['All', true],
    ['Black', false],
    ['Cappuccino', false],
    ['Latte', false],
    ['Tea', false],
  ];

  // List of coffee items with details
  final List<Map<String, dynamic>> coffeeItems = [
    {
      'name': 'Black',
      'imagePath': 'lib/images/black.png',
      'price': '4.20',
      'description': 'With sugar',
      'type': 'Black'
    },
    {
      'name': 'Cappuccino',
      'imagePath': 'lib/images/cappuccino.png',
      'price': '4.20',
      'description': 'With milk',
      'type': 'Cappuccino'
    },
    {
      'name': 'Latte',
      'imagePath': 'lib/images/latte.png',
      'price': '4.20',
      'description': 'With almond milk',
      'type': 'Latte'
    },
    {
      'name': 'Tea',
      'imagePath': 'lib/images/tea.png',
      'price': '4.20',
      'description': 'With lemon',
      'type': 'Tea'
    }
  ];

  // List of filtered coffee items
  List<Map<String, dynamic>> filteredCoffeeItems = [];

  @override
  void initState() {
    super.initState();
    // Initialize with all coffee items
    filteredCoffeeItems = List.from(coffeeItems);

    // Add listener to searchController
    searchController.addListener(() {
      filterCoffeeItems();
    });
  }

  // Method to filter coffee items based on search text
  void filterCoffeeItems() {
    String searchText = searchController.text.toLowerCase();
    setState(() {
      // Filter coffee items based on the search text
      filteredCoffeeItems = coffeeItems.where((item) {
        return item['name'].toLowerCase().contains(searchText);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }

  // User taps on coffee types
  void coffeeTypeSelected(int index) {
    setState(() {
      for (int i = 0; i < coffeeType.length; i++) {
        coffeeType[i][1] = false;
      }
      coffeeType[index][1] = true;

      String selectedType = coffeeType[index][0];
      if (selectedType == 'All') {
        // Show all items if "All" is selected
        filteredCoffeeItems = List.from(coffeeItems);
      } else {
        // Filter based on the selected coffee type
        filteredCoffeeItems = coffeeItems
            .where((item) => item['type'] == selectedType)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Find the best coffee for you
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Find the best coffee for you',
              style: GoogleFonts.bebasNeue(fontSize: 60, color: Colors.orange),
            ),
          ),
          SizedBox(height: 5),

          // SearchBar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: searchController, // Set the controller here
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Find your coffee...',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade600),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

          // Horizontal ListView of coffee types
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
                  },
                );
              },
            ),
          ),
          SizedBox(height: 20),

          // Horizontal ListView of coffee tiles
          SizedBox(
            height: 300, // Adjust this height as per your design
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filteredCoffeeItems.length,
              itemBuilder: (context, index) {
                var coffee = filteredCoffeeItems[index];
                return CoffeeTile(
                  coffeeName: coffee['name'],
                  coffeeImagePath: coffee['imagePath'],
                  coffeePrice: coffee['price'],
                  coffeeDescription: coffee['description'],
                  onTap: () {
                    // Navigate based on coffee type
                    if (coffee['type'] == 'Black') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlackCoffee(
                            coffeeName: coffee['name'],
                            coffeeImagePath: coffee['imagePath'],
                            coffeePrice: coffee['price'],
                            coffeeDescription: coffee['description'],
                          ),
                        ),
                      );
                    }

                    // Cappuccino
                    if (coffee['type'] == 'Cappuccino') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CappuccinoCoffee(
                            coffeeName: coffee['name'],
                            coffeeImagePath: coffee['imagePath'],
                            coffeePrice: coffee['price'],
                            coffeeDescription: coffee['description'],
                          ),
                        ),
                      );
                    }

                    // Latte
                    if (coffee['type'] == 'Latte') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LatteCoffee(
                            coffeeName: coffee['name'],
                            coffeeImagePath: coffee['imagePath'],
                            coffeePrice: coffee['price'],
                            coffeeDescription: coffee['description'],
                          ),
                        ),
                      );
                    }

                    // Tea
                    if (coffee['type'] == 'Tea') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Tea(
                            coffeeName: coffee['name'],
                            coffeeImagePath: coffee['imagePath'],
                            coffeePrice: coffee['price'],
                            coffeeDescription: coffee['description'],
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
