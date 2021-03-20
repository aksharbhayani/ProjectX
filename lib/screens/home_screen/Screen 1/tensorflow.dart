import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import '../../../constants.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Image Analysis",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: kPrimColor,
        elevation: 0,
      ),
      body: Container(
        color: Color(0xff392850),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                                    _outputs[0]["label"],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: getScreenWidth(22),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Open Sans"),
                                  )
                                : Container(child: Text("hey"))
                      ],
                    ),
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  tooltip: 'Pick Image',
                  onPressed: pickImage,
                  child: Icon(
                    Icons.add_a_photo,
                    size: 20,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.white,
                ),
                FloatingActionButton(
                  tooltip: 'Open Camera',
                  onPressed: pickImageCamera,
                  child: Icon(
                    Icons.camera,
                    size: 20,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
