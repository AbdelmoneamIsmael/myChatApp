import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickScreen extends StatefulWidget {
  @override
  State<ImagePickScreen> createState() => _ImagePickScreenState();
}

class _ImagePickScreenState extends State<ImagePickScreen> {
  File? myImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            myImage == null
                ? Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                  )
                : Image.file(
                    myImage!,
                    width: 100,
                    height: 100,
                  ),
            MaterialButton(
              color: Colors.black,
              onPressed: () {
                addPhoto(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addPhoto(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return Container(
              height: 300,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.camera,
                          size: 80,
                        ),
                      ),
                      const Text(
                        'Camera',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          addGalaryPhoto(context);
                        },
                        icon: const Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 80,
                        ),
                      ),
                      const Text(
                        'Galary',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> addGalaryPhoto(BuildContext context) async {
    try {
      var selectedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (selectedImage == null) return;
      var temporaryImage = File(selectedImage.path);
      myImage = temporaryImage;
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }
}
