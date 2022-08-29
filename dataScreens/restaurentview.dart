import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:resto/models/reviewmodel.dart';
import 'package:resto/utils/constants.dart';

import '../../services/fetchdata.dart';
import '../../services/sendEmail.dart';
import '../../services/upload_userdata.dart';

class RestoViewScreen extends StatefulWidget {
  final SearchResult data;
  final int index;
  const RestoViewScreen(this.data, this.index, {Key? key}) : super(key: key);

  @override
  State<RestoViewScreen> createState() => _RestoViewScreenState();
}

class _RestoViewScreenState extends State<RestoViewScreen> {
  Future<void> getData() async {
    re=[];
    DocumentReference reviews = FirebaseFirestore.instance.collection("Reviews").doc(widget.data.placeId);
    CollectionReference userreviews = reviews.collection("userReviews");
    QuerySnapshot r = await userreviews.get();
    r.docs.forEach((element) {
      re.add(ReviewModel.fromJson(element.data() as Map<String, dynamic>));
    });
    setState(() {});
  }

 List<ReviewModel> re = [];
  final uid = FirebaseAuth.instance.currentUser!.uid;

  DocumentReference<Map<String, dynamic>>? reviews;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 28,
        ),
        title: const Text('About'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              child: Container(
                height: 250,
                width: double.infinity,
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                    colors: <Color>[
                      Color(0xff000000).withOpacity(0.7),
                      Color(0xff000000).withOpacity(0.2),
                    ],
                  ),
                ),
                child: Image.memory(
                  images[widget.index] ?? Uint8List(0),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                widget.data.name as String,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Text(
                widget.data.businessStatus ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
           
        
          
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              child: Text(
                "Address :",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                widget.data.formattedAddress as String,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                "Reviews :",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: maincolor.withOpacity(0.8)),
              ),
            ),
            // ReviewsList(widget.data.placeId as String),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: re.length,
              itemBuilder: (context, i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('Users').doc(re[i].userId).snapshots(),
                        builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                          if (!snapshot.hasData) {
                            return SizedBox();
                          }
                          return ListTile(
                            leading: const CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                )),
                            title: Text(snapshot.data!['username']),
                          );
                        }),
                    RatingBarIndicator(
                      rating: re[i].rating ?? 0,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 30.0,
                    ),
                    Text(
                      re[i].review ?? "",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),

                    const SizedBox(height: 8),
                    // Text(re[i].review),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: maincolor,
          child: const Icon(Icons.reviews_rounded),
          onPressed: () {
            showModalBottomSheet<void>(
                isScrollControlled: true,
                backgroundColor: Colors.white,
                context: context,
                builder: (BuildContext context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: ReviewTab(
                      widget.data.placeId.toString(),
                      onPressed: () => getData(),
                    ),
                  );
                });
          }),
    );
  }
}

class ReviewsList extends StatefulWidget {
  final String resId;
  const ReviewsList(
    this.resId, {
    Key? key,
  }) : super(key: key);

  @override
  State<ReviewsList> createState() => _ReviewsListState();
}

class _ReviewsListState extends State<ReviewsList> {
  final List<ReviewModel> re = [];
  final uid = FirebaseAuth.instance.currentUser!.uid;

  DocumentReference<Map<String, dynamic>>? reviews;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    DocumentReference reviews = FirebaseFirestore.instance.collection("Reviews").doc(widget.resId);
    CollectionReference userreviews = reviews.collection("userReviews");
    QuerySnapshot r = await userreviews.get();
    r.docs.forEach((element) {
      re.add(ReviewModel.fromJson(element.data() as Map<String, dynamic>));
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(reviews);
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: re.length,
      itemBuilder: (context, i) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Users').doc(re[i].userId).snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox();
                  }
                  return ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        )),
                    title: Text(snapshot.data!['username']),
                  );
                }),
            RatingBarIndicator(
              rating: re[i].rating ?? 0,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 30.0,
            ),
            Text(
              re[i].review ?? "",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 8),
            // Text(re[i].review),
          ],
        ),
      ),
    );
  }
}

// for user giving reviews for restaurents

class ReviewTab extends StatefulWidget {
  final String resid;
  final Function onPressed;
  const ReviewTab(
    this.resid, {
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<ReviewTab> createState() => _ReviewTabState();
}

class _ReviewTabState extends State<ReviewTab> {
  final _reviewController = TextEditingController();
  double _rating = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
      height: 420,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Your Review",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            RatingBar.builder(
              initialRating: 0,
              glow: false,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            const SizedBox(height: 15),
            TextField(
              autofocus: false,
              controller: _reviewController,
              textCapitalization: TextCapitalization.characters,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 6,
              maxLength: 255,
              decoration: const InputDecoration(
                counterStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: maincolor, padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
                  onPressed: () {
                    uploaduserreviewdata(_reviewController.text, _rating, widget.resid);
                    EmailService().sendemail(context);
                    widget.onPressed();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
