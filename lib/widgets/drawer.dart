import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/flobalVariables.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Colors.black12,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.black87),
              margin: EdgeInsets.zero,
              accountName: Text(
                '$name',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                "$role",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: List.generate(
                fields!.length,
                (index) => InkWell(
                  child: ListTile(
                    leading: Icon(IconData(
                        int.parse('0x${fields![index]["field_icon"]}'),
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage)),
                    title: Text(
                      fields![index]['field'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 16),
                    ),
                    onTap: () {
                      setState(() {
                        Navigator.pushNamed(
                            context, (fields![index]["field_link"]));
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
