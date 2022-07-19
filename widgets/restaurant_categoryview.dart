import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';

import '../models/category.dart';
import '../services/fetchdata.dart';

class RestuarentCatergoryView extends StatefulWidget {
const  RestuarentCatergoryView({Key? key}) : super(key: key);

  @override
  State<RestuarentCatergoryView> createState() => _RestuarentCatergoryViewState();
}

class _RestuarentCatergoryViewState extends State<RestuarentCatergoryView> {
  final List<SearchResult> data = rData;

  final List<Rmodel> restos = [
    Rmodel("South central railway hotel, new delhi", "babai hotel",
        "https://images.unsplash.com/photo-1514933651103-005eec06c04b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=84&q=84"),
    Rmodel("South central railway hotel, new delhi", "babai hotel",
        "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
    Rmodel("South central railway hotel, new delhi", "babai hotel",
        "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80"),
    Rmodel("South central railway hotel, new delhi", "babai hotel",
        "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
    Rmodel("South central railway hotel, new delhi", "babai hotel",
        "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
    Rmodel("South central railway hotel, new delhi", "babai hotel",
        "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
    Rmodel("South central railway hotel, new delhi", "babai hotel",
        "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
    Rmodel("South central railway hotel, new delhi", "babai hotel",
        "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
  ];

  @override
  Widget build(BuildContext context) {
    // print(data!.first.toString());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            "Explore Restaurant",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Check your city Near by Restaurant",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (ctx, i) {
                int number = Random().nextInt(8);
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 90,
                        width: 90,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: images[i] == null
                              ? Image.network(restos[0].imgurl)
                              : Image.memory(
                                  images[i]?? Uint8List(0),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[i].name ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Color(0xFF32B768),
                                  size: 18,
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    data[i].formattedAddress ?? "",
                                    maxLines: 3,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF6B7280),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
