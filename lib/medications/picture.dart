import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Picture extends StatelessWidget {
  final String imagePath;

  const Picture({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image')),
      body: Stack(
        children: [
          Image.file(File(imagePath)),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  uploadImage();
                },
                child: const Text('Use Picture'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> uploadImage() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://722d7872-7f41-447a-b3e0-8f6308999211-00-1x7ahtemzgjf9.picard.replit.dev/'),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imagePath,
        filename: 'sample.png',
      ),
    );
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image. Error:');
    }
  }
}
