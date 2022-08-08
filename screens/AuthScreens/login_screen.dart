import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// screens
import '../../utils/constants.dart';
import '../../utils/form_spacer.dart';
import 'form_screen.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  screenanime(),
                  // Welcome data
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const FormSpacer(),
                  const Text(
                    "Before Enjoying Foodmedia services\nPlease Register First",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: fontFamily3,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // lottie animescreen
            const SizedBox(height: 40),
            textbtn(context, "Register", maincolor, Colors.white),
            textbtn(context, "Login", lmaincolor, Colors.white),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "By Logging In Or Registering ,You Have Agreed To The\nTerms And Conditions And Privacy Policy",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget screenanime() {
    return Lottie.asset(
      "assets/images/chef.json",
      animate: true,
      fit: BoxFit.contain,
      frameRate: FrameRate.max,
      height: 320,
    );
  }

  Widget textbtn(BuildContext context, String text, Color color, Color tcolor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => show(context, text),
            style: ElevatedButton.styleFrom(
              primary: color,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: tcolor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void show(ctx, text) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: bgcolor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      builder: (ctx) => FormScreen(text),
    );
  }
}
