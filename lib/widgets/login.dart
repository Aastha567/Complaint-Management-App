import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/routes.dart';
import '../utils/flobalVariables.dart';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        moveToHome(context);
        print("Login Successfully");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        role_no = output["role_id"][0]["role_id"];
        name = Name["user_name"];
        role = output["role_id"][0]["role"];
        fields = output["role_id"][0]["field_id"];
        val = prefs.getString(output["user_id"]);

        setState(() {});
        print(role_no);
        print(Name["user_name"]);
        print(output["role_id"][0]["role"]);
        print(output["role_id"][0]["field_id"]);
      } else {
        print("failed");
      }
    } catch (e) {}
  }

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changedButton = true;
      });
      await Future.delayed(
        Duration(seconds: 1),
      );
      await Navigator.pushNamed(context, "Home");
      setState(() {
        changedButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Image.asset("assets/images/login.jpeg"),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Welcome  ",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: ("Enter Username"),
                        label: Text("Username"),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username cannot be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: passController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: ("Enter Password"),
                        label: Text("Password"),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Material(
                      color: Colors.red,
                      borderRadius:
                          BorderRadius.circular(changedButton ? 45 : 10),
                      child: InkWell(
                        onTap: () async {
                          login(emailController.text, passController.text);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          width: changedButton ? 50 : 124,
                          height: 50,
                          alignment: Alignment.center,
                          child: changedButton
                              ? const Icon(
                                  Icons.done,
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(130, 5, 100, 50),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pushNamed(
                              context, MyRoutes.registrationRoute);
                        });
                      },
                      child: const Text("Register Here",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
