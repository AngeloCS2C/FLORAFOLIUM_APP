import 'package:florafolium_app/model.dart';
import 'package:florafolium_app/screens/controller/camera_initialized.dart';
import 'package:florafolium_app/screens/controller/img_prev.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as imgLib; // Import the image package
import 'dart:ui' as ui;

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final CameraInitialization _cameraInit = CameraInitialization();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeModel();
  }

  Future<void> _initializeCamera() async {
    await _cameraInit.initCamera();
    if (_cameraInit.controller != null && mounted) {
      setState(() {}); // Ensures UI updates once the camera is initialized
    }
  }

  Future<void> _initializeModel() async {
    await Model.init();
  }

  @override
  void dispose() {
    _cameraInit.dispose();
    Model.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      if (_cameraInit.controller != null &&
          _cameraInit.controller!.value.isInitialized) {
        // Camera is initialized
        await _cameraInit.initializeControllerFuture;
        final image = await _cameraInit.controller!.takePicture();
        print('Picture saved to ${image.path}');

        // Check if the image is blurry
        final isBlurry = await _isImageBlurry(File(image.path));
        if (isBlurry) {
          _showBlurDialog(); // Show the dialog for blurry images
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImagePreview(imagePath: image.path),
            ),
          );
        }
      } else {
        print('Camera not initialized');
      }
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  Future<bool> _isImageBlurry(File imageFile) async {
    // Load the image using the image package
    final imageBytes = await imageFile.readAsBytes();
    imgLib.Image? img = imgLib.decodeImage(imageBytes); // Decode image

    if (img == null) return true; // If decoding fails, treat as blurry

    // Calculate the variance of the image
    double variance = _calculateImageVariance(img);

    // Adjust threshold here (lowered to 500 for increased sensitivity)
    return variance < 500;
  }

  double _calculateImageVariance(imgLib.Image img) {
    double sum = 0;
    double sumSq = 0;
    int count = 0;

    // Iterate through each pixel in the image
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        // Get pixel value
        int pixel = img.getPixel(x, y);
        // Calculate intensity (grayscale)
        double intensity = ((imgLib.getRed(pixel) * 0.299) +
            (imgLib.getGreen(pixel) * 0.587) +
            (imgLib.getBlue(pixel) * 0.114));
        sum += intensity;
        sumSq += intensity * intensity;
        count++;
      }
    }

    final mean = sum / count;
    final variance = (sumSq / count) - (mean * mean);
    return variance;
  }

  Future<void> _openGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreview(imagePath: pickedFile.path),
        ),
      );
    } else {
      print("No image selected.");
    }
  }

  // Method to show a dialog when a blurry image is detected
  void _showBlurDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Blurry Image Detected'),
          content: const Text(
              'The image you captured appears to be blurry. Would you like to retry or cancel?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Retry'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _takePicture(); // Retry taking the picture
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Optionally, navigate back or do nothing
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size using MediaQuery
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<void>(
          future: _cameraInit.initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                _cameraInit.controller != null &&
                _cameraInit.controller!.value.isInitialized) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 6,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: double.infinity,
                              height: screenHeight * 0.6, // Dynamic height
                              child: CameraPreview(_cameraInit.controller!),
                            ),
                          ),
                          CustomPaint(
                            size: Size(double.infinity, screenHeight * 0.6),
                            painter: GridPainter(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildGalleryButton(screenWidth),
                            _buildShutterButton(screenWidth),
                            _buildHelpButton(screenWidth),
                            // Updated Help button
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _buildGalleryButton(double screenWidth) {
    return Column(
      children: [
        _buildButton(
          icon: Icons.photo_library,
          onPressed: _openGallery,
          size: screenWidth * 0.1, // Dynamic size based on screen width
        ),
        const SizedBox(height: 4), // Space between button and text
        const Text(
          'Upload',
          style: TextStyle(color: Colors.green, fontSize: 16), // Adjust style as needed
        ),
      ],
    );
  }

  Widget _buildHelpButton(double screenWidth) {
    return Column(
      children: [
        _buildButton(
          icon: Icons.question_mark,
          onPressed: _showHelpDialog,
          size: screenWidth * 0.1, // Dynamic size
        ),
        const SizedBox(height: 4), // Space between button and text
        const Text(
          'Snap Tips',
          style: TextStyle(color: Colors.green, fontSize: 16), // Adjust style as needed
        ),
      ],
    );
  }


  Widget _buildShutterButton(double screenWidth) {
    return GestureDetector(
      onTap: _takePicture,
      child: Container(
        width: screenWidth * 0.25, // Dynamic size based on screen width
        height: screenWidth * 0.25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green[700],
          border: Border.all(color: Colors.white, width: 4),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.camera,
            color: Colors.white,
            size: 60, // Reduced size for smaller screens
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback onPressed,
    required double size,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: EdgeInsets.all(size / 3), // Dynamic padding
        child: Icon(
          icon,
          color: Colors.green[700],
          size: size, // Dynamic icon size
        ),
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Snap Tips'),
          content: SizedBox(
            height: 400, // Adjust height if needed
            child: SingleChildScrollView( // Add scroll for smaller screens
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '1. FOCUS ON A SINGLE LEAF.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
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
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Got it!'),
            ),
          ],
        );
      },
    );
  }
}


  class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 1;

    double cellWidth = size.width / 3;
    double cellHeight = size.height / 3;

    for (int i = 1; i < 3; i++) {
      canvas.drawLine(Offset(i * cellWidth, 0), Offset(i * cellWidth, size.height), paint);
      canvas.drawLine(Offset(0, i * cellHeight), Offset(size.width, i * cellHeight), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
