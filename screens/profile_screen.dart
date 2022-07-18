import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:resto/constants.dart';
import 'package:resto/services/user_preferences.dart';
import 'package:resto/ui_helpers/form_spacer.dart';

import '../models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? userdata = FirebaseAuth.instance.currentUser;
  final user = UserPreferences.mydata;
  final bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: const BackButton(
          color: maincolor,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                // print(userdata);
              },
              icon: const Icon(Icons.edit, color: maincolor))
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Center(
            child: Stack(children: [
              buildImage(),
              Positioned(
                right: 3,
                bottom: 3,
                child: buildEditIcon(),
              ),
            ]),
          ),
          const FormSpacer(),
          buildProfile(),
          const FormSpacer(),
          buildAbout(user),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(userdata!.photoURL == null
        ? user.imagePath
        : userdata!.photoURL.toString());
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 160,
          height: 160,
          child: InkWell(
            splashColor: Colors.black26,
            onTap: () {},
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon() {
    return buildCircle(
      3,
      Colors.white,
      buildCircle(
        8,
        maincolor,
        Icon(
          isEdit ? Icons.add_a_photo : Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget buildCircle(double all, Color color, Widget child) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }

  Widget buildProfile() => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            user.email,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      );

  Widget buildAbout(Data user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "About",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            user.about,
            style: const TextStyle(
              height: 1.4,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
