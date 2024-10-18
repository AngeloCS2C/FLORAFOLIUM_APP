import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About This App'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.start, // Align text to the start (top)
          children: [
            SizedBox(height: 20), // Add some top space
            Text(
              'Florafolium',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'This app uses machine learning to identify plant species from images. '
              'Take a clear picture of a plant, and our model will provide you with its name, '
              'scientific classification, and description.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify, // Justify text alignment
            ),
            SizedBox(height: 20),
            Text(
              'Developed by YourName. For more information, visit our website.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20), // Add some space below
          ],
        ),
      ),
    );
  }
}
