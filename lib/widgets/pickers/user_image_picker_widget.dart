import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class UserImagePickerWidget extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;

  UserImagePickerWidget(this.imagePickFn);

  @override
  _UserImagePickerWidgetState createState() => _UserImagePickerWidgetState();
}

class _UserImagePickerWidgetState extends State<UserImagePickerWidget> {
  var _pickedImage;
  bool _isInit = true;

  void _pickAnImageWithCamera() async {
    final ImagePicker _imagePicker = ImagePicker();
    try{
    final XFile? photo = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
      maxHeight: 150,
    );
    setState(() {
      _pickedImage = File(photo!.path);
      widget.imagePickFn(_pickedImage!);
      _isInit = false;
    });
    }catch(error){
      print(error);
      setState(() {
        _isInit = true;
      });
    }
  }

  void _pickAnImageFromGalery() async {
    final ImagePicker _imagePicker = ImagePicker();
    try{
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 150,
        maxHeight: 150,
      );
      setState(() {
        _pickedImage = File(photo!.path);
        _isInit = false;
      });
      widget.imagePickFn(_pickedImage!);
    }catch(error){
      print(error);
      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage:_isInit? null
              :
          FileImage(_pickedImage!),
          child: _isInit? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(image: new AssetImage('assets/images/dummy_user.png'),
              fit: BoxFit.cover,
              ),
            ),
          )
          :
          null,
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
