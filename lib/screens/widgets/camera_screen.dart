import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
//import 'package:image/image.dart'
// as img_lib; // Renamed according to Dart convention
import 'package:logger/logger.dart';

List<CameraDescription> cameras = [];
final logger = Logger();

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key}); // Super parameter conversion

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isImagePickerActive = false;

  @override
  void initState() {
    super.initState();

    // Ensure the cameras list is populated before initializing the controller
    if (cameras.isNotEmpty) {
      controller = CameraController(cameras[0], ResolutionPreset.high);
      controller?.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } else {
      logger.e("No cameras found.");
    }
  }

  Future<void> captureImage() async {
    if (!controller!.value.isInitialized) {
      logger.e("Camera not initialized.");
      return;
    }
    if (controller!.value.isTakingPicture) {
      logger.w("Camera is currently taking a picture.");
      return;
    }

    try {
      XFile picture = await controller!.takePicture();
      setState(() {
        imageFile = picture;
      });

      if (!mounted) return; // BuildContext mounted check

      _navigateToResult(picture);
    } catch (e) {
      logger.e("Error capturing image: $e");
    }
  }

  Future<void> pickImage() async {
    if (_isImagePickerActive) {
      logger.w("Image picker is already active.");
      return;
    }
    try {
      _isImagePickerActive = true;
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      _isImagePickerActive = false;
      if (pickedFile != null) {
        setState(() {
          imageFile = pickedFile;
        });

        if (!mounted) return; // BuildContext mounted check

        _navigateToResult(pickedFile);
      }
    } catch (e) {
      _isImagePickerActive = false;
      logger.e("Error picking image: $e");
    }
  }

  Future<void> _navigateToResult(XFile image) async {
    try {
      var result = await _classifyImage(File(image.path));

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            imageFile: File(image.path),
            result: result['label'],
            confidence: result['confidence'],
          ),
        ),
      );
    } catch (e) {
      logger.e("Error navigating to result: $e");
    }
  }

  Future<Map<String, dynamic>> _classifyImage(File image) async {
    try {
      // Image classification logic
      return {
        'label': 'Sample Label',
        'confidence': 0.95,
      };
    } catch (e) {
      logger.e("Error classifying image: $e");
      rethrow;
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'FloraFolium',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 20), // Using SizedBox for spacing
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Stack(
                    children: [
                      if (controller!.value.isInitialized)
                        CameraPreview(controller!)
                      else
                        const Center(child: CircularProgressIndicator()),
                      if (imageFile != null)
                        Positioned.fill(
                          child: Image.file(
                            File(imageFile!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: IconButton(
                      icon: Image.asset('assets/upload.png'),
                      iconSize: 64,
                      onPressed: () => pickImage(),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: IconButton(
                      icon: Image.asset('assets/startcamera.png'),
                      iconSize: 64,
                      onPressed: () => captureImage(),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: IconButton(
                      icon: Image.asset('assets/tips.png'),
                      iconSize: 64,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final File imageFile;
  final String result;
  final double confidence;

  const ResultScreen({
    super.key,
    required this.imageFile,
    required this.result,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Column(
        children: [
          Image.file(imageFile),
          Text('Result: $result'),
          Text('Confidence: ${(confidence * 100).toStringAsFixed(2)}%'),
        ],
      ),
    );
  }
}
