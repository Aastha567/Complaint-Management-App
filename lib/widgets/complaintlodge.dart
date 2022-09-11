import 'package:flutter/material.dart';

import 'drawer2.dart';

class ComplaintLodge extends StatefulWidget {
  const ComplaintLodge({Key? key}) : super(key: key);

  @override
  State<ComplaintLodge> createState() => _ComplaintLodgeState();
}

class _ComplaintLodgeState extends State<ComplaintLodge> {
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