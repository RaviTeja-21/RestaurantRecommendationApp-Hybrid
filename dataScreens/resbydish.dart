import 'package:flutter/material.dart';

import '../../services/fetchdata.dart';
import '../../utils/constants.dart';
import '../../widgets/restaurant_categoryview.dart';

class RestoView extends StatefulWidget {
  final String name;
  const RestoView(this.name, {Key? key}) : super(key: key);

  @override
  State<RestoView> createState() => _RestoViewState();
}

class _RestoViewState extends State<RestoView> {
  bool isLoading = true;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    await cusinedata(widget.name);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 32,
        ),
      ),
      body: isLoading
          ? const Center(
              child: SizedBox(
                  height: 200,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: icolor,
                  ))),
            )
          : const RestuarentCatergoryView(true),
    );
  }
}
