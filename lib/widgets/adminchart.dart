import 'package:flutter/material.dart';

import 'drawer2.dart';

class AdminChart extends StatefulWidget {
  @override
  State<AdminChart> createState() => _AdminChartState();
}

class _AdminChartState extends State<AdminChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer2(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(149, 50, 144, 500),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ElevatedButton(
              child: const Text(
                "Show Chart",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
