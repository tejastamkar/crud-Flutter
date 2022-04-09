import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:image_picker/image_picker.dart';
// ignore: import_of_legacy_library_into_null_safe

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  bool _scanning = false;
  String _extractText = '';
  String _pickedImage = "";
  @override
  Widget build(BuildContext context) {
    Future<dynamic> getImage() async {
      var image =
          // ignore: invalid_use_of_visible_for_testing_member
          await ImagePicker.platform.pickImage(source: ImageSource.camera);
      late PickedFile imagePickedFile;
      setState(() {
        imagePickedFile = image as PickedFile;
        _pickedImage = imagePickedFile.path;
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text('Tesseract OCR'),
      ),
      body: ListView(
        children: [
          _pickedImage == ""
              ? Container(
                  height: 300,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image,
                    size: 100,
                  ),
                )
              : Container(
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      image: DecorationImage(
                        image: FileImage(File(_pickedImage)),
                        fit: BoxFit.fill,
                      )),
                ),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ElevatedButton(
              child: const Text(
                'Pick Image with text',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                setState(() {
                  _scanning = true;
                });
                await getImage();
                _extractText =
                    await FlutterTesseractOcr.extractText(_pickedImage);
                setState(() {
                  _scanning = false;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          _scanning
              ? const Center(child: CircularProgressIndicator())
              : const Icon(
                  Icons.done,
                  size: 40,
                  color: Colors.green,
                ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              _extractText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
