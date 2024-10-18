import 'package:camera/camera.dart';

class CameraInitialization {
  CameraController? controller;
  Future<void>? initializeControllerFuture;

  Future<void> initCamera() async {
    // Get a list of available cameras
    final cameras = await availableCameras();
    // Select the first camera
    final camera = cameras.first;

    // Create the controller
    controller = CameraController(
      camera,
      ResolutionPreset.high,
    );

    // Initialize the controller
    initializeControllerFuture = controller!.initialize();
  }

  void dispose() {
    controller?.dispose();
  }
}
