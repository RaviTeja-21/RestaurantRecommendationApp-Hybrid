import 'package:flutter/material.dart';

class ReuseBox extends StatelessWidget {
  final String title;
  final String desc;
  // final Function fx;
  // required this.fx,
  const ReuseBox({Key? key, required this.title, required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              )
            ],
          ),
          // InkWell(
          //   onTap: () => fx(),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       const Text(
          //         "See All",
          //         style: TextStyle(
          //           fontWeight: FontWeight.w500,
          //           color: Color(0xFF6B7280),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(left: 5),
          //         child: Image.asset(
          //           "assets/bnb/arrow.png",
          //           height: 10,
          //           width: 10,
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
