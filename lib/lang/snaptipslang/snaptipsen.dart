import 'package:flutter/material.dart';

class SnapTipsOverlay extends StatelessWidget {
  const SnapTipsOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Snap Tips'),
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              '1. FOCUS ON A SINGLE LEAF.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0), // Left and right padding
              child: Text(
                'Take a picture of just one leaf, so the app won’t get confused by other plants around it.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '2. CAPTURE IN GOOD LIGHTING.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Take the photo in natural daylight to ensure clear image details.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '3. CENTER THE LEAF.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Place the leaf in the center of the screen, so the app can easily identify it. Make sure the whole leaf is visible.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '4. HOLD STEADY TO AVOID BLURRY PHOTOS.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Keep your phone steady when taking the picture, so it doesn’t come out blurry.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '5. AVOID WET OR DIRTY LEAVES.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Make sure the leaf is clean and dry for better visibility of its texture, color, and structure.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '6. BACKGROUND MATTERS.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Use a plain background to ensure the leaf stands out in the image.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '7. CAPTURE DIFFERENT ANGLES.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Try different angles to capture all the details of the leaf.',
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '8. KEEP THE FRAME CLEAR.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Make sure there’s nothing else in the background, like other plants or your hand, to avoid confusing the app.',
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
