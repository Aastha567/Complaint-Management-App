import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import '/utils/flobalVariables.dart';

import '../utils/routes.dart';

class MyDrawer2 extends StatefulWidget {
  @override
  State<MyDrawer2> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer2> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var data;
  bool changedButton = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void login(String email, password) async {
    try {
      Response response = await post(
        Uri.parse("https://hello-259.herokuapp.com/rdso/post-user-api"),
        body: {"user_id": email, "password": password},
      );
      Map<String, dynamic> output = json.decode(response.body);

      var Name = json.decode(response.body);

      if (response.statusCode == 200) {
        role_no = output["role_id"][0]["role_id"];
        name = Name["user_name"];
        role = output["role_id"][0]["role"];
        fields = output["role_id"][0]["field_id"];

        setState(() {});
      }
    } catch (e) {}
  }
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
              decoration: const BoxDecoration(color: Colors.black),
              margin: EdgeInsets.zero,
              accountName: Text("${name}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text("${role}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
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
          )
        ],
      ),
    ));
  }
}
