import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final _imagePicker = ImagePicker();

  try{
    XFile? _file = await _imagePicker.pickImage(source: source);
    if(_file == null){
      return null;
    }
    return await _file.readAsBytes();
  } on PlatformException
  catch (err){
    throw err.toString();
  }

}

showSnackBar(String content, BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}