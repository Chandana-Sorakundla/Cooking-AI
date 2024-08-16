import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cookingai/api_service.dart';
import 'dart:io';

class ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      _uploadAndNavigate(File(image.path));
    }
  }

  void _uploadAndNavigate(File image) async {
    try {
      final recipe = await ApiService().fetchRecipeFromImage(image);
      Navigator.of(context).pop(recipe['dish_name']);  // Assuming you're passing back the dish name
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image and fetch recipe: $e'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload or Take a Photo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.camera),
              child: Text("Take a Picture"),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: Text("Upload from Gallery"),
            ),
          ],
        ),
      ),
    );
  }
}
