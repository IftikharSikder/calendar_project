// import 'package:flutter/Material.dart';
//
// class SearchPage extends StatelessWidget {
//   final List<String> searchResults = [
//     "Crunchy Croissants",
//     "Grilled Eggplant",
//     "Tangerine Salad",
//     "Pomegranate Juice",
//     "Chili Salsa",
//     "Bread from Scratch"
//   ];
//
//    SearchPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   prefixIcon: IconButton(onPressed: (){
//                     Navigator.of(context).pop();
//                   }, icon: Icon(Icons.arrow_back)),
//                   suffixIcon: Icon(Icons.mic),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: searchResults.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(searchResults[index]),
//                     onTap: () {}, // Can navigate to details if needed
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:animations/animations.dart';
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Home"),
//           leading: _buildSearchButton(context), // 🔹 Search Icon at Left
//         ),
//         body: Center(
//           child: Text("Click the search icon"),
//         ),
//       ),
//     );
//   }
//
//   // 🔹 Search Icon with OpenContainer animation
//   Widget _buildSearchButton(BuildContext context) {
//     return OpenContainer(
//       transitionDuration: Duration(milliseconds: 500),
//       closedElevation: 0,
//       closedShape: CircleBorder(),
//       closedColor: Colors.transparent,
//       openBuilder: (context, _) => SearchPage(),
//       closedBuilder: (context, openContainer) => IconButton(
//         icon: Icon(Icons.search, color: Colors.black),
//         onPressed: openContainer, // Opens Search Page with animation
//       ),
//     );
//   }
// }
//
// 🔹 Search Page
import 'package:flutter/Material.dart';

class SearchPage extends StatelessWidget {
  final List<String> searchResults = [
    "Crunchy Croissants",
    "Grilled Eggplant",
    "Tangerine Salad",
    "Pomegranate Juice",
    "Chili Salsa",
    "Bread from Scratch"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Folds back
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  suffixIcon: Icon(Icons.mic),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(searchResults[index]),
                    onTap: () {}, // Can navigate to details if needed
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
