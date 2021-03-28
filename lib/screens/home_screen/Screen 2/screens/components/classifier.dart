// @dart=2.11
import 'package:flutter/services.dart';
import 'package:project_app/screens/sign_up/components/signup_form.dart';

// Import tflite_flutter
import 'package:tflite_flutter/tflite_flutter.dart';

//Import twetter.dart
import 'package:twitter_api/twitter_api.dart';

// Used for the decode
import 'dart:convert';

List<String> gNegative = [];

List<String> gPositive = [];

class Classifier {
  // name of the model file
  final _modelFile = 'text_classification.tflite';
  final _vocabFile = 'text_classification_vocab.txt';

  // Maximum length of sentence
  final int _sentenceLen = 256;

  //average
  double outNegative = 0.0;
  double outPositive = 0.0;

  //list for graph

  //barGraph return value
  static double negative;
  static double positive;

  //Variable declaration
  var tweets;
  String rtext;

  //list Array
  static List<String> myList = List<String>();

  final String start = '<START>';
  final String pad = '<PAD>';
  final String unk = '<UNKNOWN>';

  Map<String, int> _dict;

  // TensorFlow Lite Interpreter object
  Interpreter _interpreter;

  Classifier() {
    // Load model when the classifier is initialized.
    _loadModel();
    _loadDictionary();
    //twitterCall();
  }

  void _loadModel() async {
    // Creating the interpreter using Interpreter.fromAsset
    _interpreter = await Interpreter.fromAsset(_modelFile);
    print('Interpreter loaded successfully');
  }

  void _loadDictionary() async {
    final vocab = await rootBundle.loadString('assets/$_vocabFile');
    var dict = <String, int>{};
    final vocabList = vocab.split('\n');
    for (var i = 0; i < vocabList.length; i++) {
      var entry = vocabList[i].trim().split(' ');
      dict[entry[0]] = int.parse(entry[1]);
    }
    _dict = dict;
    print('Dictionary loaded successfully');
  }

  Future twitterCall() async {
    // Setting placeholder api keys
    String consumerApiKey = "YJs3QLmw0d4LkAF6F9ylz8XM6";
    String consumerApiSecret =
        "3zhVFa183afvYweJoSpB77fyu0L3SlvRll5jEqj1CttbVbFvh9";
    String accessToken = "836139077145669633-myVzYH4uIugp8iNUhTl0wwrKxDrRLUb";
    String accessTokenSecret = "MvmpowSnzYdj1d6lAlqmbET3uHLKBitV4YKbaPWiOoKWN";

    // Creating the twitterApi Object with the secret and public keys
    // These keys are generated from the twitter developer page
    // Dont share the keys with anyone
    final _twitterOauth = new twitterApi(
        consumerKey: consumerApiKey,
        consumerSecret: consumerApiSecret,
        token: accessToken,
        tokenSecret: accessTokenSecret);

    // Make the request to twitter

    Future twitterRequest = _twitterOauth.getTwitterRequest(
      // Http Method
      "GET",
      // Endpoint you are trying to reach
      "statuses/user_timeline.json",
      // The options for the request
      options: {
        //"user_id": "19025957",
        "screen_name": username,
        "lang": "en",
        "count": "100",
        //"trim_user": "true",
        //"tweet_mode": "extended", // Used to prevent truncating tweets
      },
    );
    // Wait for the future to finish
    var res = await twitterRequest;

    tweets = jsonDecode(res.body);
    print(rtext);

    // for(int i=0; i<tweets.length; i++){
    //   print(tweets[i]['text']);
    //   myList.add(tweets[i]['text']);
    // }
    // print(myList);
  }

  Future classify(String rawText) async {
    // tokenizeInputText returns List<List<double>>
    // of shape [1, 256].
    rtext = rawText;
    await twitterCall();

    for (int i = 0; i < tweets.length; i++) {
      List<List<double>> input = tokenizeInputText(tweets[i]['text']);

      // output of shape [1,2].
      var output = List<double>(2).reshape([1, 2]);

      // The run method will run inference and
      // store the resulting values in output.
      _interpreter.run(input, output);

      //for graph
      if ((output[0][0] as double) > (output[0][1] as double)) {
        gNegative.add(tweets[i]['text']);
      } else {
        gPositive.add(tweets[i]['text']);
      }

      //Average
      outNegative += output[0][0];
      outPositive += output[0][1];
    }
    outNegative = outNegative / tweets.length;
    outPositive = outPositive / tweets.length;
    negative = (gNegative.length) / 100;
    positive = (gPositive.length) / 100;
    // print("new: $listnew");

    //print("new: $listnew");
    //Positive_list = gNegative.map((f) => f.split(",")[0]).toList();
    print("Positive: ${gNegative.length}");
    //print("Tweets Sepreated: $Positive_list");
    print("Negative: ${gPositive.length}");
    var result = 0;
    // If value of first element in output is greater than second,
    // then sentece is negative

    if ((outNegative) > (outPositive)) {
      result = 0;
    } else {
      result = 1;
    }
    //print(result);
    return result;
  }

  List<List<double>> tokenizeInputText(String text) {
    // Whitespace tokenization
    final toks = text.split(' ');

    // Create a list of length==_sentenceLen filled with the value <pad>
    var vec = List<double>.filled(_sentenceLen, _dict[pad].toDouble());

    var index = 0;
    if (_dict.containsKey(start)) {
      vec[index++] = _dict[start].toDouble();
    }

    // For each word in sentence find corresponding index in dict
    for (var tok in toks) {
      if (index > _sentenceLen) {
        break;
      }
      vec[index++] = _dict.containsKey(tok)
          ? _dict[tok].toDouble()
          : _dict[unk].toDouble();
    }

    // returning List<List<double>> as our interpreter input tensor expects the shape, [1,256]
    return [vec];
  }
}
