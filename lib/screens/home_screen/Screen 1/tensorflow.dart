import 'dart:async';
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_app/constants.dart';
import 'package:tflite/tflite.dart';
import '../../loading.dart';
import '../Screen 2/animation.dart';
import '../../../size_config.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'dart:ui' as ui;

class Tensorflow extends StatefulWidget {
  @override
  _TensorflowState createState() => _TensorflowState();
}

class _TensorflowState extends State<Tensorflow> {
  List _outputs;
  File _image;
  bool _loading = false;
  ui.Image image;
  int count;
  Timer timer;
  bool loadingg = false;
  bool loadingg2 = false;

  List<Rect> rect = new List<Rect>();

  var smiprob;

  Future<ui.Image> loadImage(File image) async {
    var img = await image.readAsBytes();
    return await decodeImageFromList(img);
  }

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
    Loader.hide();
  }

  pickImage() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
      rect = List<Rect>();
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
    var visionImage = FirebaseVisionImage.fromFile(_image);

    var faceDetector = FirebaseVision.instance.faceDetector(FaceDetectorOptions(
      mode: FaceDetectorMode.accurate,
      enableClassification: true,
      enableLandmarks: true,
    ));

    List<Face> faces = await faceDetector.processImage(visionImage);

    for (Face f in faces) {
      rect.add(f.boundingBox);
      smiprob = f.smilingProbability;
      print(faces);
      print(rect.length);
      count = faces.length;
      print("face: $count");
    }

    loadImage(_image).then((img) {
      setState(() {
        this.image = img;
      });
    });
    load();
  }

  set() {
    setState(() {
      loadingg2 == false;
    });
    return Container();
  }

  load() {
    Loader.show(context,
        progressIndicator: Loading(),
        overlayColor: Colors.black87,
        isAppbarOverlay: true);

    Future.delayed(Duration(seconds: 4), () {
      Loader.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dheight = MediaQuery.of(context).size.height;
    final dwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 3,
        brightness: Brightness.light,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SafeArea(
        //color: Color(0xff392850),
        child: SingleChildScrollView(
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
                        Padding(
                          padding: const EdgeInsets.only(top: 14.0),
                          child: Text(
                            'Facial Analysis',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
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
                    loadingg
                        ? Loading()
                        : Column(
                            children: [
                              Center(
                                child: image == null
                                    ? FadeAnimation(
                                        1,
                                        Column(
                                          children: [
                                            Container(
                                              height: 200,
                                              width: 200,
                                              child: Image.asset(
                                                'assets/images/spash-2.gif',
                                              ),
                                            ),
                                            Text(
                                              "No image selected",
                                              style: TextStyle(
                                                color: kPrimColor,
                                                fontSize: getScreenWidth(20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : loadingg
                                        ? Column(
                                            children: [
                                              Container(child: Loading()),
                                            ],
                                          )
                                        : image == null
                                            ? Container()
                                            : rect.length >= 1
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 300,
                                                        child: Center(
                                                          child: FittedBox(
                                                            child: SizedBox(
                                                              height: image ==
                                                                      null
                                                                  ? dheight
                                                                  : image.height
                                                                      .toDouble(),
                                                              width: image ==
                                                                      null
                                                                  ? dwidth
                                                                  : image.width
                                                                      .toDouble(),
                                                              child:
                                                                  CustomPaint(
                                                                painter: Painter(
                                                                    rect: rect,
                                                                    image:
                                                                        image),
                                                              ),
                                                            ),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "Results:\nFaces Detected: $count\nSmiling Probability: ${(smiprob * 100).toStringAsFixed(4)}%",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18),
                                                            )),
                                                      ),
                                                      //autoPress(),
                                                      Center(
                                                        child: ElevatedButton(
                                                            onPressed: () {
                                                              classifyImage(
                                                                  _image);
                                                              load();
                                                              setState(() =>
                                                                  loadingg2 =
                                                                      true);
                                                            },
                                                            child: Text(
                                                                "Check Depression")),
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      Container(
                                                        height: 300,
                                                        child: Center(
                                                          child: FittedBox(
                                                            child: SizedBox(
                                                              height: image ==
                                                                      null
                                                                  ? dheight
                                                                  : image.height
                                                                      .toDouble(),
                                                              width: image ==
                                                                      null
                                                                  ? dwidth
                                                                  : image.width
                                                                      .toDouble(),
                                                              child:
                                                                  CustomPaint(
                                                                painter: Painter(
                                                                    rect: rect,
                                                                    image:
                                                                        image),
                                                              ),
                                                            ),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                          child: Text(
                                                        "No Faces Detected",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize:
                                                                getScreenWidth(
                                                                    22),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                "Open Sans"),
                                                      )),
                                                    ],
                                                  ),
                              ),
                              loadingg2 ? resultShow() : Container(),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column resultShow() {
    return Column(
      children: [
        Center(
          child: count == 1
              ? Text(
                  "Result : ${_outputs[0]["label"]}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getScreenWidth(22),
                      fontWeight: FontWeight.bold,
                      fontFamily: "Open Sans"),
                )
              : Text(
                  "Error: More than 1 Faces detected.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: getScreenWidth(22),
                      fontWeight: FontWeight.bold,
                      fontFamily: "Open Sans"),
                ),
        ),
        set(),
      ],
    );
  }
}

class Painter extends CustomPainter {
  List<Rect> rect;
  ui.Image image;

  Painter({@required this.rect, @required this.image});

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    if (image != null) {
      canvas.drawImage(image, Offset.zero, Paint());
    }

    for (Rect rect in this.rect) {
      canvas.drawRect(
        rect,
        Paint()
          ..color = Colors.amberAccent
          ..strokeWidth = 5.0
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
