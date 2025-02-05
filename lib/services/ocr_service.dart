import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class OCRService {
  final ImagePicker _picker = ImagePicker();

  Future<String?> extractTextFromImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    final File file = File(image.path);
    final inputImage = InputImage.fromFile(file);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText = await textDetector.processImage(inputImage);

    textDetector.close();
    return recognizedText.text;
  }
}
