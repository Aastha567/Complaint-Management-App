import 'package:flutter/material.dart';
import '../utils/flobalVariables.dart';
import '/widgets/drawer.dart';
import '/widgets/drawer2.dart';
import '/utils/routes.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.red),
        title: Text(
          "${role} Page",
          style: TextStyle(color: Color.fromARGB(255, 246, 68, 33)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ElevatedButton(
              child: Text("Complaint Lodge"),
              onPressed: () {
                setState(() {
                  Navigator.pushNamed(context, "Complaint");
                });
              },
            ),
            ElevatedButton(
              child: const Text("Complaint Status"),
              onPressed: () {
                setState(() {
                  Navigator.pushNamed(context, MyRoutes.homeRoute2);
                });
              },
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
