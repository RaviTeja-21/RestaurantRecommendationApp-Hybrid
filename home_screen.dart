import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/profile_screen.dart';
import '../services/fetchdata.dart';
import '../services/userlocation.dart';
import '../widgets/dish_categoryview.dart';
import '../constants.dart';
import '../widgets/restaurant_categoryview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  final user = FirebaseAuth.instance.currentUser;
  int currentIndex = 0;
  bool isloading = true;

  String? location = "My Location";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // placedata(); 
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
        titleTextStyle: const TextStyle(color: Color(0xFF4B5563), fontWeight: FontWeight.w500, fontFamily: fontFamily, fontSize: 15),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              color: Color(0xFF32B768),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(location ?? "",
                  style: const TextStyle(
                    overflow: TextOverflow.fade,
                  )),
            ),
          ],
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DishCategoryView(),
            isloading ? Container(height: 200, child: const Center(child: CircularProgressIndicator())) : RestuarentCatergoryView(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        )),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (i) => setState(() => currentIndex = i),
          selectedItemColor: const Color(0xFF32B768),
          unselectedItemColor: const Color(0xFF374151),
          iconSize: 30,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "", backgroundColor: maincolor),
            BottomNavigationBarItem(icon: Icon(Icons.description), label: "", backgroundColor: maincolor),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "", backgroundColor: maincolor),
          ],
        ),
      ),
    );
  }
}
