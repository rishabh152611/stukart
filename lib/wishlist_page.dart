import 'package:flutter/material.dart';
import 'app_data.dart';
import 'cart.dart';
import 'homepage.dart';
import 'profile.dart';

class WishlistPage extends StatefulWidget {
  // Removed the const constructor to ensure state rebuilds correctly.
  WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  void _removeFromWishlist(int index) {
    setState(() {
      AppData.wishlist.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Item removed from wishlist."),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _moveToCart(int index) {
    final item = AppData.wishlist[index];
    setState(() {
      AppData.wishlist.removeAt(index);
      AppData.cart.add(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${item['title']} moved to cart!"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _moveAllToCart() {
    final count = AppData.wishlist.length;
    setState(() {
      AppData.cart.addAll(AppData.wishlist);
      AppData.wishlist.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$count items moved to cart!"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _navigateBottomBar(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Homepage()),
        );
        break;
      case 1:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Chat page not implemented")),
        );
        break;
      case 2:
      // Already on Wishlist page, do nothing.
        break;
      case 3:
        Navigator.pushReplacement(
          context,
            MaterialPageRoute(builder: (_) => CartScreen())
        );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        backgroundColor: Colors.orange,
      ),
      body: AppData.wishlist.isEmpty
          ? const Center(
          child: Text(
            "Your wishlist is empty.",
            style: TextStyle(fontSize: 18),
          ))
          : ListView.builder(
        itemCount: AppData.wishlist.length,
        itemBuilder: (context, index) {
          final item = AppData.wishlist[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Image.asset(
                item['image']!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(
                item['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item['subtitle']!),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item['price']!,
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart, color: Colors.green),
                    onPressed: () => _moveToCart(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => _removeFromWishlist(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (AppData.wishlist.isNotEmpty)
            SafeArea(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _moveAllToCart,
                    label: const Text(
                      "Move All to Cart",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            currentIndex: 2,
            onTap: _navigateBottomBar,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ],
      ),
    );
  }
}
