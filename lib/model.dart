import 'package:tflite_v2/tflite_v2.dart';

class Model {
  static Future<void> init() async {
    await Tflite.loadModel(
      model: 'model/FloraFolium.tflite', // Path to your model file
      labels: 'model/label.txt', // Path to your labels file
    );
  }

  static Future<List?> predict(String imagePath) async {

      var prediction = await Tflite.runModelOnImage(
        path: imagePath,
        threshold: 0.5, // Minimum confidence threshold
      );
      return prediction;

      // Assuming that the labels file contains the names and descriptions
      // Map<String, Map<String, String>> plantData = {
      //   'PlantName1': {
      //     'description': 'Description of Plant 1',
      //     'type': 'Scientific Type 1',
      //   },
      //   'PlantName2': {
      //     'description': 'Description of Plant 2',
      //     'type': 'Scientific Type 2',
      //   },
      //   // Add more plants as needed
      // };
      //
      // if (prediction != null && prediction.isNotEmpty) {
      //   for (var pred in prediction) {
      //     String label = pred['label'];
      //     if (plantData.containsKey(label)) {
      //       pred['description'] = plantData[label]!['description'];
      //       pred['type'] = plantData[label]!['type'];
      //     } else {
      //       pred['description'] = 'No description available';
      //       pred['type'] = 'No type available';
      //     }
      //   }
      // }
      //
      //   return prediction?.map<Map<String, dynamic>>((pred) {
      //     return {
      //       'label': pred['label'],
      //       'confidence': pred['confidence'],
      //       'description': pred['description'] ?? 'No description available',
      //       'type': pred['type'] ?? 'No type available',
      //     };
      //   }).toList();
      // } catch (e) {
      //   print("Error during prediction: $e");
      //   return null; // Return null on error
      // }

  }

  static Future<void> dispose() async {
    await Tflite.close(); // Close TFLite resources
  }
}
