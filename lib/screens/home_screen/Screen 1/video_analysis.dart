import 'dart:collection';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_app/screens/home_screen/Screen%202/constants.dart';
import 'package:project_app/screens/loading.dart';
import 'package:video_player/video_player.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

String keyss;

class videoAnalysis extends StatefulWidget {
  @override
  _videoAnalysisState createState() => _videoAnalysisState();
}

class _videoAnalysisState extends State<videoAnalysis> {
  File videoFile;
  var emo = {
    'angry': 0,
    'disgust': 0,
    'fear': 0,
    'happy': 0,
    'sad': 0,
    'surprise': 0,
    'neutral': 0
  };

  void getResponse() async {
    //var url = Uri.parse('https://325d972884e6.ngrok.io/');
    var url = Uri.https('da452fa95efa.ngrok.io', '/uploads');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      for (var key in jsonResponse) {
        if (key['result'] == 'angry0') {
          emo['angry'] += 1;
        } else if (key['result'] == 'disgust0') {
          emo['disgust'] += 1;
        } else if (key['result'] == 'fear0') {
          emo['fear'] += 1;
        } else if (key['result'] == 'happy0') {
          emo['happy'] += 1;
        } else if (key['result'] == 'sad0') {
          emo['sad'] += 1;
        } else if (key['result'] == 'surprise0') {
          emo['surprise'] += 1;
        } else {
          emo['neutral'] += 1;
        }
      }
      print(emo);
      var sortedKeys = emo.keys.toList(growable: false)
        ..sort((k1, k2) => emo[k1].compareTo(emo[k2]));
      LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(sortedKeys,
          key: (k) => k, value: (k) => emo[k]);
      List keys = sortedMap.keys.toList();
      List values = sortedMap.values.toList();
      print(keys[6]);
      print(values[6]);
      keyss = keys[6];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    //print(await http.read('https://example.com/foobar.txt'));
  }

  _videoPic() async {
    File theVid = await ImagePicker.pickVideo(
        source: ImageSource.gallery, maxDuration: Duration(seconds: 10));
    if (theVid == null) return null;

    setState(() {
      videoFile = theVid;
    });
  }

  _videoRec() async {
    File theVid = await ImagePicker.pickVideo(
        source: ImageSource.camera, maxDuration: Duration(seconds: 10));
    if (theVid == null) return null;

    setState(() {
      videoFile = theVid;
    });
  }

  load1() {
    Loader.show(context,
        progressIndicator: Loading(),
        overlayColor: Colors.black87,
        isAppbarOverlay: true);

    Future.delayed(Duration(seconds: 25), () {
      Loader.hide();
    });
  }

  load2() {
    Loader.show(context,
        progressIndicator: Loading(),
        overlayColor: Colors.black87,
        isAppbarOverlay: true);

    Future.delayed(Duration(seconds: 40), () {
      Loader.hide();
    });
  }

  @override
  void setStatee() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Video Analysis",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    FloatingActionButton.extended(
                      heroTag: "btn1",
                      tooltip: 'Pick Image',
                      onPressed: () {
                        _videoPic();
                        setState(() {
                          keyss = null;
                        });
                      },
                      label: Text("Gallery"),
                      icon: Icon(
                        Icons.video_library,
                        size: 20,
                        color: Colors.white,
                      ),
                      backgroundColor: kPrimColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FloatingActionButton.extended(
                      heroTag: "btn2",
                      tooltip: 'Open Camera',
                      onPressed: () {
                        _videoRec();
                        setState(() {
                          keyss = null;
                        });
                      },
                      label: Text("Record Video"),
                      icon: Icon(
                        Icons.videocam_sharp,
                        size: 25,
                        color: Colors.white,
                      ),
                      backgroundColor: kPrimColor,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * (70 / 100),
                  width: MediaQuery.of(context).size.width * (100 / 100),
                  child: videoFile == null
                      ? Center(
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                child: Image.asset(
                                  'assets/images/spash-2.gif',
                                ),
                              ),
                              Text(
                                "No video selected",
                                style: TextStyle(
                                  color: kPrimColor,
                                  fontSize: getScreenWidth(20),
                                ),
                              ),
                            ],
                          ),
                        )
                      : FittedBox(
                          fit: BoxFit.contain,
                          child: mounted
                              ? Chewie(
                                  controller: ChewieController(
                                    videoPlayerController:
                                        VideoPlayerController.file(videoFile),
                                    aspectRatio: 9 / 16,
                                    autoPlay: true,
                                  ),
                                )
                              : Container(),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                    onPressed: () async {
                      final Reference firebaseStorageRef = FirebaseStorage
                          .instance
                          .ref()
                          .child('videos')
                          .child('new.mp4');
                      final UploadTask task =
                          firebaseStorageRef.putFile(videoFile);

                      load1();
                      Fluttertoast.showToast(
                        msg: "Uploading video to servers...",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                      );
                      await Future.delayed(Duration(seconds: 25));
                      Fluttertoast.showToast(
                        msg: "Uploaded Successfully",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                      );
                      load2();
                      getResponse();
                      Fluttertoast.showToast(
                        msg: "Checking for emotions...",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                      );
                      await Future.delayed(Duration(seconds: 40));
                      Fluttertoast.showToast(
                        msg: "Successfully detected!",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                      );

                      setStatee();
                    },
                    child: Text("Check depression")),
              ),
              keyss == null
                  ? Container()
                  : Center(
                      child: Container(
                          child: Text('Result: $keyss',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getScreenWidth(22),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Open Sans"))),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
