import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'app_data.dart'; // using our unified shared state
import 'cart.dart';
import 'wishlist_page.dart';
import 'profile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove plain backgroundColor and let the gradient show
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade100, Colors.orange.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting Row
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage("assets/avatar.jpg"),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Hey ${user?.displayName ?? user?.email ?? 'Rockstar'}!",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                            fontFamily: 'RobotoMono',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Stack(
                        children: [
                          const Icon(Icons.notifications_none,
                              color: Colors.orange, size: 28),
                          Positioned(
                            right: 0,
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.red,
                              child: const Text(
                                '7',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),

                // Logo & Tagline
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Image.asset('assets/logo.png', height: 60),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          "Making your college\nlife easier with STUKART!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.orange),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: "What would you like to search?",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 8),
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.filter_list,
                              color: Colors.orange),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Filter Chips
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      FilterChip(
                        label: const Text("All"),
                        selected: true,
                        selectedColor: Colors.orange,
                        labelStyle: const TextStyle(color: Colors.white),
                        onSelected: (_) {},
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text("Second hand"),
                        selected: false,
                        selectedColor: Colors.orange,
                        onSelected: (_) {},
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          "See More >",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Product Grid (vibrant and funky cards)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                    children: [
                      buildProductCard(
                        image: 'assets/maths quan.jpg',
                        title: 'Maths Quantum',
                        subtitle: 'Second hand',
                        price: 'RS 89',
                      ),
                      buildProductCard(
                        image: 'assets/cooler.png',
                        title: 'Cooler',
                        subtitle: '3-year old',
                        price: 'RS 1500',
                      ),
                      buildProductCard(
                        image: 'assets/chair.jpeg',
                        title: 'Rolling Chair',
                        subtitle: 'Second hand',
                        price: 'RS 499',
                      ),
                      buildProductCard(
                        image: 'assets/drafter.jpg',
                        title: 'Mini Drafter',
                        subtitle: '6 Months Old',
                        price: 'RS 99',
                      ),
                      buildProductCard(
                        image: 'assets/DSA.jpg',
                        title: 'Striver DSA Course',
                        subtitle: 'Lifetime Access',
                        price: 'RS 199',
                      ),
                      buildProductCard(
                        image: 'assets/Referral-_Program1200x600-1.png',
                        title: 'Referral',
                        subtitle: '',
                        price: '',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),

      // Vibrant Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepPurple.shade100,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey.shade700,
        currentIndex: 0,
        onTap: (index) {
          if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => WishlistPage()),
            ).then((_) => setState(() {}));
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CartScreen()),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProfilePage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget buildProductCard({
    required String image,
    required String title,
    required String subtitle,
    required String price,
  }) {
    final bool isInWishlist =
    AppData.wishlist.any((item) => item['title'] == title);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.orange.shade50],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.asset(
                  image,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    isInWishlist
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isInWishlist) {
                        AppData.wishlist
                            .removeWhere((item) => item['title'] == title);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                              Text('$title removed from wishlist')),
                        );
                      } else {
                        AppData.wishlist.add({
                          'image': image,
                          'title': title,
                          'subtitle': subtitle,
                          'price': price,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$title added to wishlist')),
                        );
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.orange,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.orange,
                      ),
                      onPressed: () {
                        setState(() {
                          AppData.cart.add({
                            'image': image,
                            'title': title,
                            'subtitle': subtitle,
                            'price': price,
                          });
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$title added to cart')),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
