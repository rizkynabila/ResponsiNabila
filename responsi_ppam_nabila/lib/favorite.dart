import 'package:flutter/material.dart';
import 'home.dart';

class Favorite extends StatefulWidget {
  final List<dynamic> favoriteItems;

  const Favorite({super.key, required this.favoriteItems});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(), 
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: widget.favoriteItems.isEmpty
          ? const Center(
              child: Text('No items in favorites'),
            )
          : ListView.builder(
              itemCount: widget.favoriteItems.length,
              itemBuilder: (context, index) {
                final amiibo = widget.favoriteItems[index];
                return ListTile(
                  leading: Image.network(amiibo['image']),
                  title: Text(amiibo['name']),
                  subtitle: Text(amiibo['gameSeries']),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
