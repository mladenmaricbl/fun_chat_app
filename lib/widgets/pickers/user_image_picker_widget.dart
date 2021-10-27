import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class UserImagePickerWidget extends StatefulWidget {

  @override
  _UserImagePickerWidgetState createState() => _UserImagePickerWidgetState();
}

class _UserImagePickerWidgetState extends State<UserImagePickerWidget> {
  File _pickedImage = File('assets/images/waiting.png');

  void _pickAnImageWithCamera() async {
    final ImagePicker _imagePicker = ImagePicker();
    try{
    final XFile? photo = await _imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = File(photo!.path);
    });
    }catch(error){
      print(error);
    }
  }

  void _pickAnImageFromGalery() async {
    final ImagePicker _imagePicker = ImagePicker();
    try{
      final XFile? photo = await _imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _pickedImage = File(photo!.path);
      });
    }catch(error){
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: FileImage(_pickedImage),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: _pickAnImageWithCamera,
              icon: Icon(Icons.camera_alt_outlined),
              label: Text('Take a photo'),
            ),
            FlatButton.icon(
              onPressed: _pickAnImageFromGalery,
              icon: Icon(Icons.image_outlined),
              label: Text('Choose from gallery'),
            )
          ],
        ),
      ],
    );
  }
}
