// ignore_for_file: avoid_print

import 'package:florafolium_app/screens/about.dart';
import 'package:florafolium_app/screens/widgets/camera_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'images/florafolium-9-5-2024.png', // Adjust the path to your logo
              fit: BoxFit.contain,
              height: 30, // Adjust height as needed
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Remove shadow if not needed
        actions: [
          // Language selector first
          SizedBox(
            width: 50, // Set the width of the icon
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.language,
                  color: Colors.green, size: 28), // Resize the icon
              onSelected: (String value) {
                // Handle the language change here
                print('Selected language: $value');
                // You can implement your language change logic here
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'English',
                    child: Text('English'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Tagalog',
                    child: Text('Tagalog'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Cebuano',
                    child: Text('Cebuano'),
                  ),
                ];
              },
            ),
          ),
          // About this app icon at the end
          IconButton(
            icon: const Icon(Icons.info, color: Colors.green),
            onPressed: () {
              // Navigate to About Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: CameraScreen(),
      ),
    );
  }
}
