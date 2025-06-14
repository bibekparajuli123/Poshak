import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedBottomNav = 0;
  int _cartCount = 2; // Sample cart count

  // Dummy data (no image paths required)
  final List<Map<String, String>> trendingProducts = [
    {'name': 'Dhaka Topi', 'price': 'Rs. 500'},
    {'name': 'Kurta Set', 'price': 'Rs. 1800'},
    {'name': 'Sari', 'price': 'Rs. 2500'},
  ];

  final List<Map<String, String>> categories = [
    {'name': 'Men', 'icon': '👔'},
    {'name': 'Women', 'icon': '👗'},
    {'name': 'Kids', 'icon': '🧒'},
    {'name': 'Accessories', 'icon': '👜'},
    {'name': 'Ethnic', 'icon': '🧣'},
  ];

  final List<Map<String, String>> recommendedProducts = [
    {'name': 'Pashmina Shawl', 'price': 'Rs. 1200'},
    {'name': 'Gunyo Cholo', 'price': 'Rs. 3500'},
    {'name': 'Daura Suruwal', 'price': 'Rs. 2200'},
  ];

  void _onDrawerItemTap(String route) {
    Navigator.pop(context);
    if (route == 'Logout') {
      Navigator.pushReplacementNamed(context, '/signin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Color(0xFF800000)),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          'Poshak',
          style: GoogleFonts.poppins(
            color: Color(0xFF800000),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Color(0xFF800000)),
            onPressed: () {},
          ),
          SizedBox(width: 8),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          children: [
            _buildSearchBar(),
            SizedBox(height: 20),
            _sectionTitle('Trending Products'),
            SizedBox(
              height: 210,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: trendingProducts.length,
                separatorBuilder: (context, index) => SizedBox(width: 14),
                itemBuilder: (context, index) =>
                    _productCard(trendingProducts[index]),
                physics: ClampingScrollPhysics(),
              ),
            ),
            SizedBox(height: 28),
            _sectionTitle('Categories'),
            SizedBox(
              height: 70,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) => SizedBox(width: 12),
                itemBuilder: (context, index) => _categoryCard(categories[index]),
                physics: ClampingScrollPhysics(),
              ),
            ),
            SizedBox(height: 28),
            _sectionTitle('Recommended For You'),
            ...recommendedProducts.map(
              (product) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _recommendedProductCard(product),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 24),
            CircleAvatar(
              radius: 38,
              backgroundColor: Color(0xFF800000),
              child: Text(
                'U',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'User Name',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'user@email.com',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 24),
            Divider(),
            _drawerItem(Icons.home, 'Home'),
            _drawerItem(Icons.category, 'Categories'),
            _drawerItem(Icons.shopping_bag, 'Orders'),
            _drawerItem(Icons.settings, 'Settings'),
            _drawerItem(Icons.logout, 'Logout'),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF800000)),
      title: Text(label, style: GoogleFonts.poppins(fontSize: 16)),
      onTap: () => _onDrawerItemTap(label),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedBottomNav,
      onTap: (idx) {
        setState(() {
          _selectedBottomNav = idx;
        });
      },
      selectedItemColor: Color(0xFF800000),
      unselectedItemColor: Colors.grey[600],
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_rounded),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: badges.Badge(
            showBadge: _cartCount > 0,
            badgeContent: Text(
              '$_cartCount',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            badgeStyle: badges.BadgeStyle(badgeColor: Color(0xFF800000)),
            child: Icon(Icons.shopping_cart_outlined),
          ),
          label: 'Cart',
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for products',
                border: InputBorder.none,
                hintStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.filter_alt_outlined, color: Color(0xFF800000)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 2),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF800000),
        ),
      ),
    );
  }

  Widget _productCard(Map<String, String> product) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 140,
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xFF800000).withAlpha(18),
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Icon(Icons.image, color: Color(0xFF800000), size: 48),
          ),
          SizedBox(height: 10),
          Text(
            product['name']!,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6),
          Text(
            product['price']!,
            style: GoogleFonts.poppins(
              color: Color(0xFF800000),
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _categoryCard(Map<String, String> category) {
    return Container(
      width: 90,
      decoration: BoxDecoration(
        color: Color(0xFF800000).withAlpha(18),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF800000).withAlpha(18)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(category['icon']!, style: TextStyle(fontSize: 28)),
            SizedBox(height: 6),
            Text(
              category['name']!,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xFF800000),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recommendedProductCard(Map<String, String> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 60,
          height: 70,
          decoration: BoxDecoration(
            color: Color(0xFF800000).withAlpha(18),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.image, color: Color(0xFF800000), size: 32),
        ),
        title: Text(
          product['name']!,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Text(
          product['price']!,
          style: GoogleFonts.poppins(
            color: Color(0xFF800000),
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.add_shopping_cart, color: Color(0xFF800000)),
          onPressed: () {
            setState(() {
              _cartCount++;
            });
          },
        ),
      ),
    );
  }
}
