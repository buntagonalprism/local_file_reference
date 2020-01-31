import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_file_reference/local_file_reference.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int bytes;
  LocalFileReference ref;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(onPressed: _pickImage, child: Text('Pick Image')),
            SizedBox(height: 16.0),
            Center(
              child: Text('Selected Image Size: ${bytes ?? "None selected"}'),
            ),
            ref != null
                ? Image(
                    image: ref.imageProvider,
                    height: 72,
                    width: 72,
                  )
                : Icon(
                    Icons.camera,
                    size: 72,
                  ),
          ],
        ),
      ),
    );
  }

  void _pickImage() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    print('local_file_reference: Picked image at path ' + file.path);
    final imageRef = LocalFileReference(file.path);
    final dartLength = await file.length();
    print('local_file_reference: dart file length: ' + dartLength.toString());
    final fileCopy = File(file.path);
    final copyByes = await fileCopy.length();
    print('local_file_reference: copied dart file length: ' +
        copyByes.toString());
    final imageBytes = await imageRef.retrieveData();

    setState(() {
      bytes = imageBytes.length;
      ref = imageRef;
    });
  }
}
