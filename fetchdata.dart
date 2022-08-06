import 'dart:typed_data';

import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;

List<SearchResult> _rData = [];
List<SearchResult> get rData => _rData;

List<Uint8List?> images = [];

Future placedata() async {
  _rData = [];
  images = [];
  var googlePlace = GooglePlace("AIzaSyDE0rEZMQN8UeMSzhAKPMcDCdfvN4mOCF0");

  var result = await googlePlace.search.getTextSearch("nearby restaurants");
  _rData = result!.results!;
  // SearchResult res = _rData.first;
  // List<Photo>? ph = res.photos;
  await Future.forEach(_rData, (SearchResult element) async {
    images.add(null);
    String? image = element.photos?.first.photoReference!;
    var response = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=$image&key=AIzaSyDE0rEZMQN8UeMSzhAKPMcDCdfvN4mOCF0"));
    // print(response.bodyBytes);
    images.last = response.bodyBytes;
    // print(images.last);
  });
  print("resdata");
  // https://maps.googleapis.com/maps/api/place/photo?parameters
  // print(ph!.first.);
}

Future cusinedata(String search) async {
  _rData = [];
  images = [];
  var googlePlace = GooglePlace("AIzaSyDE0rEZMQN8UeMSzhAKPMcDCdfvN4mOCF0");

  var result = await googlePlace.search.getTextSearch('$search restaurants');
  _rData = result!.results!;
  // SearchResult res = _rData.first;
  // List<Photo>? ph = res.photos;
  await Future.forEach(_rData, (SearchResult element) async {
    images.add(null);
    String? image = element.photos?.first.photoReference!;
    var response = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=$image&key=AIzaSyDE0rEZMQN8UeMSzhAKPMcDCdfvN4mOCF0"));
    // print(response.bodyBytes);
    images.last = response.bodyBytes;
    // print(images.last);
  });
  print("cusdata");
  // https://maps.googleapis.com/maps/api/place/photo?parameters
  // print(ph!.first.);
}
