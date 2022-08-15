import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:resto/utils/constants.dart';
import 'package:resto/services/showsnackbar.dart';
import 'package:resto/services/upload_userdata.dart';

import '../../main.dart';
import '../../providers/fb_sign_in.dart';
import '../../providers/google_sign_in.dart';
import '../../utils/form_spacer.dart';
import '../../widgets/textfieldcontainer.dart';
import 'forget_password.dart';

class FormScreen extends StatefulWidget {
  final String text;
  const FormScreen(this.text, {Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _addressController = TextEditingController();
  bool isuserLogging = false;

  @override
  void initState() {
    if (widget.text == "Login") {
      isuserLogging = true;
    }
    super.initState();
  }

  void toggle() => setState(() {
        isuserLogging = !isuserLogging;
      });
  @override
  void dispose() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    switcher("Register", isuserLogging ? lmaincolor : maincolor),
                    switcher("Login", isuserLogging ? maincolor : lmaincolor),
                  ],
                ),
              ),
              const FormSpacer(),
              if (!isuserLogging) ...[
                // profile field
                TextFieldContainer(
                  controller: _nameController,
                  labelText: "Full Name",
                  hintText: "Enter your full name",
                  validator: (name) => name!.isEmpty ? "Please enter the profile name" : null,
                ),
                TextFieldContainer(
                  controller: _addressController,
                  labelText: "Address",
                  hintText: "Enter your address",
                  validator: (name) => name!.isEmpty ? "Please enter the address" : null,
                ),
              ],
              // email field
              TextFieldContainer(
                controller: _emailController,
                labelText: "Email address",
                hintText: "Eg nameemail@email.com",
                validator: (email) => email != null && !EmailValidator.validate(email) ? 'Enter a valid email' : null,
              ),
              // password field
              TextFieldContainer(
                controller: _passwordController,
                labelText: "Password",
                hintText: "Password",
                validator: (value) => value != null && value.length < 8 ? 'Enter minimum 8 characters' : null,
                obscureText: true,
              ),
               if (!isuserLogging) ...[
                // profile field
                TextFieldContainer(
                  controller: _confirmController,
                  labelText: "Confirm Password",
                  hintText: "Password",
                  validator: (name) => _passwordController.text!= _confirmController.text ? "Password doesn't match" : null,
                ),
               ],
              isuserLogging
                  ? signbtn(
                      context,
                      _nameController,
                      _emailController,
                      _passwordController,
                    )
                  : signbtn(
                      context,
                      _nameController,
                      _emailController,
                      _passwordController,
                    ),
    
              // Forgot Password
              isuserLogging
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        child: const Text(
                          'Forget Password?',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ForgetPasswordPage()));
                        },
                      ),
                    )
                  : const SizedBox(),
    
              // Google signin button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 64),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    width: double.infinity,
                    child: SignInButton(
                      Buttons.Google,
                      text: "Sign up with Google",
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                        provider.googleLogin(context);
                      },
                    ),
                  ),
                ),
              ),
              // facebook signin button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 64),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    width: double.infinity,
                    child: SignInButton(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      Buttons.FacebookNew,
                      text: "Sign up with Facebook",
                      onPressed: () {
                        final provider = Provider.of<FbSignInProvider>(context, listen: false);
                        provider.fbLogin(context);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget signbtn(ctx, name, email, password) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 65),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isuserLogging ? () async => await login(ctx, email, password) : () async => await register(ctx, name, email, password),
            style: ElevatedButton.styleFrom(
              primary: maincolor,
              padding: const EdgeInsets.symmetric(vertical: 18),
              textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            child: Text(
              isuserLogging ? "Login" : "Register",
              style:const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

// signing up user and logining user in firebase functions

  Future login(ctx, email, password) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(context: ctx, barrierDismissible: false, builder: (context) => const Center(child: CircularProgressIndicator(color: maincolor)));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(ctx, e.message.toString());
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future register(ctx, name, email, password) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(context: ctx, barrierDismissible: false, builder: (context) => const Center(child: CircularProgressIndicator(color: maincolor)));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      uploaddata(name.text.trim(), _addressController.text);
    } on FirebaseAuthException catch (e) {
      showSnackBar(ctx, e.message.toString());
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Widget switcher(text, color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: RichText(
        text: TextSpan(
          recognizer: TapGestureRecognizer()..onTap = toggle,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          text: text,
        ),
      ),
    );
  }
}
