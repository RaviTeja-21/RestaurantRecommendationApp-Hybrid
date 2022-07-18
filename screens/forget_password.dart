import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:resto/screens/login_screen.dart';

import '../constants.dart';
import '../main.dart';
import '../services/showsnackbar.dart';
import '../ui_helpers/form_spacer.dart';
import '../widgets/textfieldcontainer.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.clear();
    super.dispose();
  }

  Future<void> resetPassword(BuildContext context, email) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
            const Center(child: CircularProgressIndicator(color: maincolor)));
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Success()));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      "Forget Password",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const FormSpacer(),
                    const Text(
                      "Enter your registered email below",
                      style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 56),
                    // email field
                    TextFieldContainer(
                      controller: _emailController,
                      labelText: "Email address",
                      hintText: "Eg nameemail@email.com",
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter a valid email'
                              : null,
                    ),
                    // back to sign in
                    Padding(
                      padding: const EdgeInsets.only(top: 6, left: 12),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w500,
                          ),
                          text: "Remember the password?  ",
                          children: [
                            TextSpan(
                              text: "Sign in",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pop();
                                },
                              style: const TextStyle(
                                fontSize: 15,
                                color: maincolor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //
                  ],
                ),
              ),
            ),
            // submit button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: maincolor,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    onPressed: () {
                      resetPassword(context, _emailController.text);
                    },
                    child: const Text("Submit"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Success extends StatelessWidget {
  const Success({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/check-mark.png",
                    width: 80,
                    height: 80,
                  ),
                  const Text(
                    "Success",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  const FormSpacer(),
                  const Text(
                    "Please check your email for create\na new password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 12),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF9CA3AF),
                          fontWeight: FontWeight.w700,
                        ),
                        text: "Can't get email?  ",
                        children: [
                          TextSpan(
                            text: "Resubmit",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pop();
                              },
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFF32B768),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF32B768),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text("Back Email"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

//         resetPassword(context, _emailController.text.trim()),

Future<void> resetPassword(BuildContext context, email) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          const Center(child: CircularProgressIndicator(color: maincolor)));
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    // ignore: use_build_context_synchronously
    showSnackBar(context, "Email for Password Reset has been sent");
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  } on FirebaseAuthException catch (e) {
    showSnackBar(context, e.message.toString());
    Navigator.of(context).pop();
  }
}
