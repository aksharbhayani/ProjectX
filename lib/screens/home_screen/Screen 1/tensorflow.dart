import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import '../Screen 2/animation.dart';
import '../../../size_config.dart';

class Tensorflow extends StatefulWidget {
  @override
  _TensorflowState createState() => _TensorflowState();
}

class _TensorflowState extends State<Tensorflow> {
  List _outputs;
  File _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model/facial/model_unquant.tflite",
      labels: "assets/model/facial/labels.txt",
      numThreads: 1,
    );
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    cropImage();
  }

  pickImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    cropImage();
  }

  cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _image.path,
    );
    setState(() {
      _loading = true;
      _image = cropped ?? _image;
    });
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        brightness: Brightness.light,
        leading: Icon(null),
      ),
      body: SafeArea(
        //color: Color(0xff392850),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        'Facial Analysis',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        FloatingActionButton(
                          heroTag: "btn1",
                          tooltip: 'Pick Image',
                          onPressed: pickImage,
                          child: Icon(
                            Icons.add_a_photo,
                            size: 20,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.yellow[700],
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        FloatingActionButton(
                          heroTag: "btn2",
                          tooltip: 'Open Camera',
                          onPressed: pickImageCamera,
                          child: Icon(
                            Icons.camera,
                            size: 20,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.yellow[700],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _loading
                      ? Container(
                          height: 300,
                          width: 300,
                        )
                      : Container(
                          margin: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _image == null ? Container() : Image.file(_image),
                              SizedBox(
                                height: 20,
                              ),
                              _image == null
                                  ? Container()
                                  : _outputs != null
                                      ? Text(
                                          "Result : ${_outputs[0]["label"]}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: getScreenWidth(22),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Open Sans"),
                                        )
                                      : Container(child: Text("hey"))
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
