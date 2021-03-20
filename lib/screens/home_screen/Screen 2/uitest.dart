import 'dart:io';
import 'package:flutter/material.dart';
import 'animation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import '../../../size_config.dart';

class Uitest extends StatefulWidget {
  @override
  _UitestState createState() => _UitestState();
}

class _UitestState extends State<Uitest> {
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
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_basket,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SafeArea(
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _loading != true
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
                                  _image == null
                                      ? Container()
                                      : Image.file(_image),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  _image == null
                                      ? Container()
                                      : _outputs == null
                                          ? Text(
                                              "Result: ${_outputs[0]["label"]}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: getScreenWidth(22),
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Open Sans"),
                                            )
                                          : Container(child: Text(""))
                                ],
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeCategory({isActive, title}) {
    return AspectRatio(
      aspectRatio: isActive ? 3 : 2.5 / 1,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: isActive ? Colors.yellow[700] : Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Align(
          child: Text(
            title,
            style: TextStyle(
                color: isActive ? Colors.white : Colors.grey[500],
                fontSize: 18,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w100),
          ),
        ),
      ),
    );
  }

  Widget makeItem({image}) {
    return AspectRatio(
      aspectRatio: 1 / 1.5,
      child: GestureDetector(
        child: Container(
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              )),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.bottomCenter, stops: [
                  .2,
                  .9
                ], colors: [
                  Colors.black.withOpacity(.9),
                  Colors.black.withOpacity(.3),
                ])),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "\$ 15.00",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Vegetarian Pizza",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
