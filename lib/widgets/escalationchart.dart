import 'package:flutter/material.dart';

class EscalationChart extends StatefulWidget {
  @override
  State<EscalationChart> createState() => _EscalationChartState();
}

class _EscalationChartState extends State<EscalationChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
