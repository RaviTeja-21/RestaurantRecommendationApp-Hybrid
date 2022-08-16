import 'package:flutter/material.dart';
import 'package:resto/models/category.dart';

import '../screens/dataScreens/resbydish.dart';
import '../utils/constants.dart';
import '../utils/form_spacer.dart';
import 'reuse_box.dart';

class DishCategoryView extends StatelessWidget {
  DishCategoryView({Key? key}) : super(key: key);
  // list of dishes
  final List<DishCategory> dishes = [
    DishCategory(
      "Biryani",
      "https://images.unsplash.com/photo-1631515243349-e0cb75fb8d3a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1188&q=80",
    ),
    DishCategory(
      "Burger and fries",
      "https://images.unsplash.com/photo-1561758033-d89a9ad46330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YnVyZ2VyJTIwYW5kJTIwZnJpZXN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
    ),
    DishCategory(
      "Noodles",
      "https://images.unsplash.com/photo-1553621043-f607bfbf6640?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=80",
    ),
    DishCategory(
      "Chicken Soup",
      "https://images.unsplash.com/photo-1512003867696-6d5ce6835040?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
    ),
    DishCategory(
      "Fried rice",
      "https://images.unsplash.com/photo-1596560548464-f010549b84d7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
    ),
    DishCategory(
      "Pizza",
      "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
    ),
    DishCategory(
      "Samosa",
      "https://images.unsplash.com/photo-1601050690294-397f3c324515?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
    ),
    DishCategory(
      "Chapathi",
      "https://b.zmtcdn.com/data/pictures/chains/7/19188717/0e4513426cae57e5c7fab814933f8a9a.jpg",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const ReuseBox(
          title: "Cuisines",
          desc: "Best of the today food list update",
        ),
        const FormSpacer(),
        SizedBox(
          height: size.height * 0.21,
          child: ListView.builder(
              padding: const EdgeInsets.only(left: 18),
              scrollDirection: Axis.horizontal,
              itemCount: dishes.length,
              itemBuilder: (ctx, i) {
                final data = dishes[i];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RestoView(data.name)),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 15),
                    width: 150,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: Image.network(
                            data.imgurl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: size.height * 0.135,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          data.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}


                        // const SizedBox(height: 6),
                        // Row(
                        //   children: [
                        //     const Icon(
                        //       Icons.location_on,
                        //       color: icolor,
                        //       size: 18,
                        //     ),
                        //     const SizedBox(width: 5),
                        //     Flexible(
                        //       child: Text(
                        //         data.address,
                        //         style: const TextStyle(
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.w500,
                        //           color: Color(0xFF6B7280),
                        //           overflow: TextOverflow.fade,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),


// return Padding(
//       padding: const EdgeInsets.only(left: 18),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           const Text(
//             "Today New Arivable",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           const Text(
//             "Best of the today food list update",
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//               color: Color(0xFF6B7280),
//             ),
//           ),
//           const FormSpacer(),
//           SizedBox(
//             height: 170,
//             child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: dishes.length,
//                 itemBuilder: (ctx, i) {
//                   Size size = MediaQuery.of(context).size;
//                   return Container(
//                     margin: const EdgeInsets.only(right: 12),
//                     width: 150,
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFFFFFFF),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(12),
//                               topRight: Radius.circular(12)),
//                           child: Center(
//                             child: SizedBox(
//                               height: size.height * 0.1,
//                               width: double.infinity,
//                               child: Image.network(
//                                 dishes[i].imgurl,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Text(
//                           dishes[i].name,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                             color: Color(0xFF1F2937),
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             const Icon(
//                               Icons.location_on,
//                               color: Color(0xFF32B768),
//                               size: 16,
//                             ),
//                             const SizedBox(width: 5),
//                             Flexible(
//                               child: Text(
//                                 dishes[i].address,
//                                 style: const TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   color: Color(0xFF6B7280),
//                                   overflow: TextOverflow.fade,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//           ),
//         ],
//       ),
//     );