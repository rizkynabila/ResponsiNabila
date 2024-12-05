import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final Map<String, dynamic> amiibo;

  const Detail({super.key, required this.amiibo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(amiibo['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                amiibo['image'],
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Name: ${amiibo['name']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Game Series: ${amiibo['gameSeries']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Type: ${amiibo['type']}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
