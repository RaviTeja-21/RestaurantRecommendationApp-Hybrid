import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ui
import 'package:resto/constants.dart';
// providers
import '/providers/google_sign_in.dart';
import 'providers/fb_sign_in.dart';
// screens
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FbSignInProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Food World',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: fontFamily,
          // primaryColor: maincolor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: maincolor,));
            } else if (snapshot.hasData) {
              return  const HomeScreen();
            } else if (snapshot.hasError) {
              return const Center(child: Text("Something Went Wrong!"));
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
