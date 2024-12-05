import 'package:flutter/material.dart';
import 'splash.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Nitendo Amiibo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Splash(), 
    );
  }
}
