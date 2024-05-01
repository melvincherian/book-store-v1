// import 'package:flutter/material.dart';
// import 'package:project_week8/screens/productdetails.dart';

// class ScreenProduct extends StatelessWidget {
//   const ScreenProduct({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 255, 242, 242),
//         title: const Text(
//           'Products',
//           style: TextStyle(fontSize: 38, color: Colors.black),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 20),
//           // Divider between AppBar and search controller
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             alignment: Alignment.center,
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search...',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const MyProducts()));
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.blue,
//       ),
//     );
//   }
// }
