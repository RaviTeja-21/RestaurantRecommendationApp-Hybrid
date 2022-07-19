import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:resto/services/showsnackbar.dart';

import '../constants.dart';
import '../main.dart';
import '../services/upload_userdata.dart';

class FbSignInProvider extends ChangeNotifier {
  final fbSignIn = FacebookAuth.instance;
  Map? _userData;
  Map get userData => _userData!;

  Future fbLogin(context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
            const Center(child: CircularProgressIndicator(color: maincolor)));
    try {
      final fbUser = await fbSignIn.login();
      if (fbUser.status == LoginStatus.success) {
        final fbuserData = await fbSignIn.getUserData();
        // print(fbuserData);
        _userData = fbuserData;

        // you are logged
        final OAuthCredential credential =
            FacebookAuthProvider.credential(fbUser.accessToken!.token);
        await FirebaseAuth.instance.signInWithCredential(credential);
        uploaduserData(context, "facebook");
      }
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      return;
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }

    notifyListeners();
  }

}
