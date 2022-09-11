// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_login1/utils/routes.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart';
// import '/widgets/homepage.dart';
// import 'widgets/login.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(MyWidget());
// }

// class MyWidget extends StatefulWidget {
//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   final url = "https://hello-259.herokuapp.com/rdso/models";
//   var postsJson = [];
//   void fetchPosts() async {
//     try {
//       final response = await get(
//         Uri.parse(url),
//       );
//       final jsonData = jsonDecode(response.body) as List;
//       postsJson = jsonData;
//     } catch (err) {}
//   }

//   void initState() {
//     super.initState();
//     fetchPosts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     fetchPosts();
//     return MaterialApp(
//       home: Scaffold(
//         body: ListView.builder(
//           itemBuilder: (context, i) {
//             final post = postsJson[i];
//             return (Text("Title: ${post['user_name']}"));
//           },
//           itemCount: postsJson.length,
//         ),
//       ),
//     );
//   }
// }
