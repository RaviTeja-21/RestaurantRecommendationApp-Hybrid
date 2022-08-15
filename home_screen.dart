import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/fetchdata.dart';
import '../services/sendEmail.dart';
import '../services/userlocation.dart';
import '../widgets/dish_categoryview.dart';
import '../utils/constants.dart';
import '../widgets/restaurant_categoryview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final user = FirebaseAuth.instance.currentUser;
  bool isloading = true;

  String? location = "Welcome";

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    location = await LocationHelper.getPlaceAddress();
    await placedata();

    if (mounted) {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    // EmailService().sendemail(context);
                  },
                  icon: const Icon(Icons.logout, size: 30)),
              title: const Text('Log Out'),
            )
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFF374151)),
        toolbarHeight: 54,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Color(0xFF4B5563),
            fontWeight: FontWeight.w500,
            fontFamily: fontFamily,
            fontSize: 15),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                color: icolor,
              ),
              const SizedBox(width: 5),
              Text(location ?? "",
                  style: const TextStyle(
                    overflow: TextOverflow.fade,
                  )),
            ],
          ),
        ),
        actions: [
          // Container(
          //   height: 40,
          //   width: 40,
          //   padding: const EdgeInsets.only(right: 10),
          //   child: user!.photoURL == null
          //       ? CircleAvatar(
          //           child: Icon(Icons.account_circle),
          //         )
          //       : CircleAvatar(
          //           backgroundImage: NetworkImage(
          //             user!.photoURL as String,
          //           ),
          //         ),
          // ),
          IconButton(
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (c) => const ProfileScreen()));
            },
            icon: user!.photoURL == null
                ? const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.account_circle,
                      size: 32,
                      color: Colors.black,
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(
                      user!.photoURL as String,
                    ),
                  ),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DishCategoryView(),
          isloading
              ? const SizedBox(
                  height: 300,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: icolor,
                  )))
              : const RestuarentCatergoryView(false),
        ],
      ),
    );
  }
}
