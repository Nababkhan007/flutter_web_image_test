import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const WebImageTest());
}

class WebImageTest extends StatelessWidget {
  const WebImageTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Web Image Test",
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
  PlatformFile? _imageFile;

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        withData: true,
        withReadStream: true,
        type: FileType.image,
      );

      if (result == null) return;

      setState(() {
        _imageFile = result.files.first;
      });
    } catch (e) {
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
        title: const Text(
          "Web Image Test",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null)
              FutureBuilder(
                future: _imageFile!.readStream!.first,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Image.memory(
                      snapshot.data,
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text(
                "Pick an image",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
