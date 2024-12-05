import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'detail.dart';
import 'favorite.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<dynamic> amiiboList = [];
  final Set<dynamic> favoriteItems = {}; 

  @override
  void initState() {
    super.initState();
    _fetchAmiiboData();
  }

  Future<void> _fetchAmiiboData() async {
    final url = Uri.parse('https://www.amiiboapi.com/api/amiibo');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        amiiboList = data['amiibo'];
      });
    } else {
      throw Exception('Failed to fetch Amiibo data');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Favorite(
            favoriteItems: favoriteItems.toList(),
          ),
        ),
      );
    }
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
      (route) => false,
    );
  }

  void _toggleFavorite(dynamic amiibo) {
    setState(() {
      if (favoriteItems.contains(amiibo)) {
        favoriteItems.remove(amiibo);
      } else {
        favoriteItems.add(amiibo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Nitendo Amiibo List',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: _logout,
          ),
        ],
      ),
      body: amiiboList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: amiiboList.length,
                itemBuilder: (context, index) {
                  final amiibo = amiiboList[index];
                  final isFavorite = favoriteItems.contains(amiibo);
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Detail(amiibo: amiibo),
                              ),
                            );
                          },
                          child: Image.network(
                            amiibo['image'],
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          amiibo['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            _toggleFavorite(amiibo);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
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
