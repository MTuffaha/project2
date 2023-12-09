import 'package:flutter/material.dart';
import 'profile.dart';
import 'payment_screen.dart';

class FoodDeliveryApp extends StatelessWidget {
  static Restaurant? selectedRestaurant;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExpressEats',
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Your Restaurant'),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                restaurants[index].name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              leading: Image.asset(
                restaurants[index].image,
                width: 50,
                height: 50,
              ),
              onTap: () {
                FoodDeliveryApp.selectedRestaurant = restaurants[index];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestaurantPage(
                      restaurant: restaurants[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Me',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        onTap: (int index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(), // Navigate to ProfilePage
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(),
              ),
            );
          }
        },
      ),
    );
  }
}
class RestaurantPage extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildMenuSection('Appetizers', restaurant.menu.where((item) => item.category == 'Appetizer').toList()),
            buildMenuSection('Main Courses', restaurant.menu.where((item) => item.category == 'Main Course').toList()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Me',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        onTap: (int index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(), // Navigate to ProfilePage
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildMenuSection(String title, List<FoodItem> items) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${items[index].name} - \$${items[index].price}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (FoodDeliveryApp.selectedRestaurant == restaurant) {
                              ShoppingCart.addItem(items[index], () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${items[index].name} added to cart.'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Cannot add items from different restaurants to the cart.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(235, 121, 121, 1),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    leading: Image.asset(
                      items[index].image,
                      width: 50,
                      height: 50,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Text('Cart Items:'),
          ...ShoppingCart.items.map((item) => Card(
            elevation: 2,
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(item.name),
              subtitle: Text('\$${item.price}'),
              trailing: IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: () {
                  ShoppingCart.removeItem(item, () {
                    setState(() {}); // Trigger a rebuild
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item.name} removed from the cart.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  });
                },
              ),
            ),
          )),
          ElevatedButton(
            onPressed: () {
              // Navigate to PaymentScreen when "Proceed to Order" is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentScreen(),
                ),
              );
            },
            child: Text('Proceed to Order'),
          ),
          Text('Total: \$${ShoppingCart.calculateTotal()}'),
        ],
      ),
    );
  }
}

class Restaurant {
  final String name;
  final String image;
  final List<FoodItem> menu;

  Restaurant(this.name, this.image, this.menu);
}

class FoodItem {
  final String name;
  final String image;
  final double price;
  final String category; // 'Appetizer', 'Main Course', or 'Dessert'

  FoodItem(this.name, this.image, this.price, this.category);
}

class ShoppingCart {
  static List<FoodItem> items = [];

  static void addItem(FoodItem item, VoidCallback onCartChanged) {
    items.add(item);
    onCartChanged();
  }

  static void removeItem(FoodItem item, VoidCallback onCartChanged) {
    items.remove(item);
    onCartChanged();
  }

  static double calculateTotal() {
    return items.fold(0, (sum, item) => sum + item.price);
  }
}

void main() {
  runApp(FoodDeliveryApp());
}

List<Restaurant> restaurants = [
  Restaurant(
    'Bella Italia',
    'assets/Italian.jpg',
    [
      FoodItem('Bruschetta', 'assets/Bruschetta.jpg', 5.0, 'Appetizer'),
      FoodItem('Calamari Fritti', 'assets/CalamariFritti.jpg', 8.0, 'Appetizer'),
      FoodItem('Chicken Alfredo', 'assets/ChickenAlfredo.jpg', 10.0, 'Main Course'),
      FoodItem('Risotto with Porcini Mushrooms', 'assets/Risotto.jpg', 12.0, 'Main Course'),
      FoodItem('Spaghetti Bolognese', 'assets/SpaghettiBolognese.jpg', 8.0, 'Main Course'),
    ],
  ),
  Restaurant(
    'Casa de Sabor',
    'assets/Mexican.jpg',
    [
      FoodItem('Guacamole & Chips', 'assets/Guacamole.jpg', 7.0, 'Appetizer'),
      FoodItem('Quesadilla', 'assets/Quesadilla.jpg', 8.0, 'Appetizer'),
      FoodItem('Chicken Enchilidas', 'assets/ChickenEnchiladas.jpg', 10.0, 'Main Course'),
      FoodItem('Shrimp Fajitas', 'assets/ShrimpFajitas.jpg', 10.0, 'Main Course'),
      FoodItem('Tacos', 'assets/Tacos.jpg', 10.0, 'Main Course'),
    ],
  ),
  Restaurant(
    'Dragon Delight',
    'assets/Chinese.jpg',
    [
      FoodItem('Spring Rolls', 'assets/SpringRolls.jpg', 8.0, 'Appetizer'),
      FoodItem('Dim Sum', 'assets/DimSum.jpg', 6.0, 'Appetizer'),
      FoodItem('Kung Pao Shrimp', 'assets/KungPaoShrimp.jpg', 12.0, 'Main Course'),
      FoodItem('Mongolian Beef', 'assets/MongolianBeef.jpg', 12.0, 'Main Course'),
      FoodItem('Sweet and Sour Chicken', 'assets/SweetSourChicken.jpg', 12.0, 'Main Course'),
    ],
  ),
  Restaurant(
    'Le Petit Bistro',
    'assets/French.jpg',
    [
      FoodItem('Escargot', 'assets/Escargot.jpg', 15.0, 'Appetizer'),
      FoodItem('Quiche Lorraine', 'assets/QuicheLorraine.jpg', 8.0, 'Appetizer'),
      FoodItem('Beef Bourguignon', 'assets/BeefBourguignon.jpg', 18.0, 'Main Course'),
      FoodItem('Coq au Vin', 'assets/CoqauVin.jpg', 18.0, 'Main Course'),
      FoodItem('Ratatouille', 'assets/Ratatouille.jpg', 18.0, 'Main Course'),
    ],
  ),
  Restaurant(
    'Olive Grove Taverna',
    'assets/Mediterranean.jpg',
    [
      FoodItem('Baba Ganoush', 'assets/BabaGanoush.jpg', 8.0, 'Appetizer'),
      FoodItem('Hummus with Pita', 'assets/HummusPita.jpg', 6.0, 'Appetizer'),
      FoodItem('Falafel Wrap', 'assets/FalafelWrap.jpg', 7.0, 'Main Course'),
      FoodItem('Lamb Kebabs', 'assets/LambKebabs.jpg', 7.0, 'Main Course'),
      FoodItem('Shawarma', 'assets/Shawarma.jpg', 10.0, 'Main Course'),
    ],
  ),
  Restaurant(
    'Sakura Sushi House',
    'assets/Japanese.jpg',
    [
      FoodItem('Agedashi Tofu', 'assets/AgedashiTofu.jpg', 4.0, 'Appetizer'),
      FoodItem('Miso Soup', 'assets/MisoSoup.jpg', 5.0, 'Appetizer'),
      FoodItem('Ramen', 'assets/Ramen.jpg', 18.0, 'Main Course'),
      FoodItem('Sushi', 'assets/Sushi.jpg', 15.0, 'Main Course'),
      FoodItem('Teriyaki Salmon', 'assets/TeriyakiSalmon.jpg', 18.0, 'Main Course'),
    ],
  ),
  Restaurant(
    'Smokin Grillhouse',
    'assets/American.jpg',
    [
      FoodItem('BBQRibs', 'assets/BBQRibs.jpg', 15.0, 'Appetizer'),
      FoodItem('Jalapeño Poppers', 'assets/JalapenoPoppers.jpg', 15.0, 'Appetizer'),
      FoodItem('Beef Brisket', 'assets/BeefBrisket.jpg', 18.0, 'Main Course'),
      FoodItem('Grilled Chicken', 'assets/GrilledChicken.jpg', 18.0, 'Main Course'),
      FoodItem('Pulled Pork Sandwich', 'assets/PulledPorkSandwich.jpg', 18.0, 'Main Course'),
    ],
  ),
  Restaurant(
    'Spice Paradise',
    'assets/Indian.jpg',
    [
      FoodItem('Aloo Tikki', 'assets/AlooTikki.jpg', 6.0, 'Appetizer'),
      FoodItem('Samosas', 'assets/Samosas.jpg', 6.0, 'Appetizer'),
      FoodItem('Chicken Tikka Masala', 'assets/ChickenTikkaMasala.jpg', 12.0, 'Main Course'),
      FoodItem('Lamb Curry', 'assets/LambCurry.jpg', 12.0, 'Main Course'),
      FoodItem('Vegetable Biryani', 'assets/VegetableBiryani.jpg', 10.0, 'Main Course'),
    ],
  ),
  Restaurant(
    'Thai Orchid Garden',
    'assets/Thai.jpg',
    [
      FoodItem('Chicken Satay', 'assets/ChickenSatay.jpg', 6.0, 'Appetizer'),
      FoodItem('Spring Rolls', 'assets/SpringRolls.jpg', 6.0, 'Appetizer'),
      FoodItem('Basil Fried Rice', 'assets/BasilFriedRice.jpg', 12.0, 'Main Course'),
      FoodItem('Green Curry', 'assets/GreenCurry.jpg', 10.0, 'Main Course'),
      FoodItem('Pad Thai', 'assets/PadThai.jpg', 12.0, 'Main Course'),
    ],
  ),
];

class Cart {
  static List<FoodItem> items = []; // Stores added items

  static int get cartItemsCount => items.length;

  static void addItem(FoodItem item) {
    items.add(item);
  }

  static void removeItem(FoodItem item) {
    items.remove(item);
    onCartChanged();
  }

  static void onCartChanged() {} // Returns the number of items in the cart
}

class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(Icons.shopping_cart),
        if (Cart.cartItemsCount > 0)
          Positioned(
            right: 0,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              child: Text('${Cart.cartItemsCount}'),
            ),
          ),
      ],
    );
  }
}