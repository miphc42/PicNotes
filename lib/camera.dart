
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File _image;
  var all = new List();
  Future getImage() async{
  var image;
  image = await ImagePicker.pickImage(source: ImageSource.camera);
  var cropImage = ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      )
    );
  File croppedFile = await cropImage;
    
    setState((){
      _image = croppedFile;
    });
    final File imageFile = _image;
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    final VisionText visionText = await textRecognizer.processImage(visionImage);
    String text = visionText.text;
    all.clear();
    for (TextBlock block in visionText.blocks) {
      final Rect boundingBox = block.boundingBox;
      final List<Offset> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<RecognizedLanguage> languages = block.recognizedLanguages;
      setState(() {
          all.add(text);
      });
      print(text);
    for (TextLine line in block.lines) {
        // Same getters as TextBlock
      for (TextElement element in line.elements) {
      }
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Camera',
      home: new Scaffold(
        appBar: new AppBar(
          title: Text('Camera'),
        ),
        body:Center(
              child: ListView.builder(
            itemCount: all.length,
              itemBuilder: (context, i){
                  return ListTile(
                    title: Text(all[i]),
                  );
                
      },
              )
              // child: _image == null? Text('No Image Selected'): Image.file(_image),
            ),
            // Text(
            //   all.length > 0 ? all[0]: ''
            //   ,
        floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          tooltip: 'Pick Image',
          child: Icon(
            Icons.camera
          ),
        ),

        )
      );}
}