import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:appwrite/appwrite.dart';
import '../app_config.dart';


class UploadImagePage extends StatefulWidget {
  final Storage storage;
  final Client client;
  const UploadImagePage({super.key, required this.storage, required this.client});

  @override
  State<UploadImagePage> createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  File? _imageFile;

  /// Pick an image from the gallery
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      print("No image selected");
    }
  }

  /// Upload the selected image to Appwrite
  Future<void> uploadImage() async {
    if (_imageFile == null) {
      print("No image to upload");
      return;
    }

    try {
      final result = await widget.storage.createFile(
        bucketId: AppConfig.storageBucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: _imageFile!.path),
      );

      print("File uploaded successfully: ${result.$id}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image uploaded successfully!")),
      );
    } on AppwriteException catch (e) {
      print("Error uploading image: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.message}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(
              _imageFile!,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            )
                : Text("No image selected"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImage,
              child: Text("Pick Image"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: uploadImage,
              child: Text("Upload Image"),
            ),
          ],
        ),
      ),
    );
  }
}
