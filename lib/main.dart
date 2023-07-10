import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'KindaCode.com',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FilePickerExample(),
    );
  }
}

class FilePickerExample extends StatefulWidget {
  const FilePickerExample({Key? key}) : super(key: key);

  @override
  State<FilePickerExample> createState() => _FilePickerExampleState();
}

class _FilePickerExampleState extends State<FilePickerExample> {
  // Variable to hold the selected image file
  PlatformFile? _imageFile;

  // Method to pick and display an image file
  Future<void> _pickImage() async {
    try {
      // Pick an image file using file_picker package
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      // If user cancels the picker, do nothing
      if (result == null) return;

      // If user picks an image, update the state with the new image file
      setState(() {
        _imageFile = result.files.first;
      });
    } catch (e) {
      // If there is an error, show a snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KindaCode.com'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // If image file is not null, display it using Image widget
            if (_imageFile != null)
              Image.memory(
                Uint8List.fromList(_imageFile!.bytes!),
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            // A button to trigger the file picker dialog
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick an image'),
            ),
          ],
        ),
      ),
    );
  }
}