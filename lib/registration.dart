import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '/widgets/homepage.dart';
import 'widgets/login.dart';
//import 'package:rdsocomplain/homepage.dart';
//import 'package:rdsocomplain/pages/dashboard.dart';
//import 'package:rdsocomplain/pages/login.dart';
//import 'package:rdsocomplain/pages/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:mailer/mailer.dart';
//import 'package:mailer/smtp_server.dart';
//import 'package:email_validator/email_validator.dart';
import '/utils/routes.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Register();
  }
}

class _Register extends State<Register> {
  late String errormsg;
  late bool error, showprogress;
  late String ipasid, name, email, mobile, designation;
  late String ipasid1, name1, email1, mobile1, designation1;
  bool _isLoading = true;

  var _ipasid = TextEditingController();
  var _name = TextEditingController();
  var _email = TextEditingController();
  var _mobile = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var _ipasid1 = TextEditingController();
  var _name1 = TextEditingController();
  var _email1 = TextEditingController();
  var _mobile1 = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();

  var _selectedCategory;
  var _selectedCategory2; // new1
  var _selectedCategoryId;

  var _selectedCategory1;
  // var _selectedCategory3; // new2
  var _selectedCategoryId1;
  var _desig;
  bool _isShowDesigError = false;
  bool showGlobalError = false;

  List _designation = [];

  var EmailValidator;
  Future desig() async {
    List data = [];
    http.Response response;
    String api =
        "https://complaint-app-rdso.herokuapp.com/designation/"; //api url
    response = await http.get(Uri.parse(api));
    var responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      // print('response from 200 $responseData');
      if (responseData.isNotEmpty) {
        for (var i = 0; i < responseData.length; i++) {
          data.add(responseData[i]);
        }

        setState(() {
          _designation.addAll(data);
          // print("data of designation $_designation");
          _isLoading = false;
        });
      } else {
        // print('response from 400 $responseData');
        _isLoading = false;
      }
    }
  }

  List _directorate = [];
  Future direc() async {
    List data = [];
    http.Response response;
    String api =
        "https://complaint-app-rdso.herokuapp.com/department/"; //api url
    response = await http.get(Uri.parse(api));
    var responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      // print('response from 200 $responseData');
      if (responseData.isNotEmpty) {
        for (var i = 0; i < responseData.length; i++) {
          // print(responseData[i]);
          data.add(responseData[i]);
        }

        setState(() {
          _directorate.addAll(data);
          // print("data of designation $_directorate");
          _isLoading = false;
        });
      } else {
        // print('response from 400 $responseData');
        _isLoading = false;
      }
    }
  }

  // void sendMail(){
  //   String username = 'username@gmail.com';
  //   String password = 'password';
  //   final smtpServer = gmail(username, password);
  // }

  @override
  void initState() {
    ipasid = "";
    name = "";
    email = "";
    mobile = "";
    errormsg = "";
    error = false;
    showprogress = false;
    Future.delayed(Duration.zero, () async {
      //  Location(context);
      desig();
      direc();
    });
    super.initState();
  }

  Registeremp(var flag) async {
    print(flag);
    if (flag == 1) {
      if (_formKey.currentState!.validate()) {
        String apiurl =
            "https://complaint-app-rdso.herokuapp.com/register/"; //api url
        //dont use http://localhost , because emulator don't get that address
        //insted use your local IP address or use live URL
        //hit "ipconfig" in windows or "ip a" in linux to get you local IP

        // print(ipasid+" YE HAI ID");
        //  print(name+" YE HAI NAME");
        //  print(email+" YE HAI EMAIL");
        //  print(mobile+" YE HAI NUMBER");
        //  print(_selectedCategory+" YE HAI DESIGNATION");
        //  print(_selectedCategory1+" YE HAI DEPARTMENT");
        var response = await http.post(Uri.parse(apiurl),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'ipasid': ipasid, //get the ipasid text
              'name': name, //get name text
              'email': email, //get email text
              'mobile': mobile, //get mobile text
              'designation': _selectedCategory,
              'department': _selectedCategory1,
            }));
        print(response.body);
        if (response.statusCode == 200) {
          var jsondata = json.decode(response.body);

          // print("login token" + response.toString());
          if (jsondata["error"]) {
            setState(() {
              showprogress = false; //don't show progress indicator
              error = true;
              errormsg = jsondata["message"];
            });
          } else {
            if (jsondata["success"]) {
              setState(() {
                error = false;
                showprogress = false;
              });
              //save the data returned from server
              //and navigate to login page

              //user shared preference to save data
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()),
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> Route) => false,
              );
              //  Navigator.pushAndRemoveUntil(context,  , (route) => false);
              // Get.toNamed('homepage');

            } else {
              showprogress = false; //don't show progress indicator
              error = true;
              errormsg = "Something went wrong.";
            }
          }
        } else {
          setState(() {
            showprogress = false; //don't show progress indicator
            error = true;
            errormsg = "Error during connecting to server.";
          });
        }
      } else {
        setState(() {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Enter Correct Values";
        });
      }
    } else {
      if (_formKey1.currentState!.validate()) {
        String apiurl =
            "https://complaint-app-rdso.herokuapp.com/registernonrdso/"; //api url
        //dont use http://localhost , because emulator don't get that address
        //insted use your local IP address or use live URL
        //hit "ipconfig" in windows or "ip a" in linux to get you local IP

        print(ipasid1 + " YE HAI ID");
        print(name1 + " YE HAI NAME");
        print(email1 + " YE HAI EMAIL");
        print(mobile1 + " YE HAI NUMBER");
        // print(_selectedCategory+" YE HAI DESIGNATION");
        print(_selectedCategory2 + " YE HAI DEPARTMENT");
        var response = await http.post(Uri.parse(apiurl),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'ipasid': ipasid1, //get the ipasid text
              'name': name1, //get name text
              'email': email1, //get email text
              'mobile': mobile1, //get mobile text
              'department': _selectedCategory2,
            }));
        print(response.body);
        if (response.statusCode == 200) {
          var jsondata = json.decode(response.body);

          // print("login token" + response.toString());
          if (jsondata["error"]) {
            setState(() {
              showprogress = false; //don't show progress indicator
              error = true;
              errormsg = jsondata["message"];
            });
          } else {
            if (jsondata["success"]) {
              setState(() {
                error = false;
                showprogress = false;
              });
              //save the data returned from server
              //and navigate to login page

              //user shared preference to save data
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()),
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> Route) => false,
              );
              //  Navigator.pushAndRemoveUntil(context,  , (route) => false);
              // Get.toNamed('homepage');

            } else {
              showprogress = false; //don't show progress indicator
              error = true;
              errormsg = "Something went wrong.";
            }
          }
        } else {
          setState(() {
            showprogress = false; //don't show progress indicator
            error = true;
            errormsg = "Error during connecting to server.";
          });
        }
      } else {
        setState(() {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Enter Correct Values";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent
            //color set to transperent or set your own color
            ));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple.shade400,
            title: Text("Register Employee"),
            bottom: TabBar(
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.purple,
              ),
              tabs: [
                Tab(text: "RDSO Employee"),
                Tab(text: "Non RDSO Employee")
              ],
            ),
          ),
          body: TabBarView(children: [
            SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Container(
                constraints:
                    BoxConstraints(minHeight: MediaQuery.of(context).size.height
                        //set minimum height equal to 100% of VH
                        ),
                width: MediaQuery.of(context).size.width,
                //make width of outer wrapper to 100%
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.purple.shade400,
                      Colors.purple.shade300,
                      Colors.purple.shade200,
                      Colors.purple.shade100,
                    ],
                  ),
                ), //show linear gradient background of page

                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Column(children: <Widget>[
                  // Container(
                  //   margin: EdgeInsets.only(top: 50),
                  //   child: Text(
                  //     "Register Employee",
                  //     style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 30,
                  //         fontWeight: FontWeight.bold),
                  //   ), //title text
                  // ),
                  Container(
                    //show error message here
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.all(10),
                    child: error ? errmsg(errormsg) : Container(),
                    //if error == true then show error message
                    //else set empty container as child
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: _ipasid, //set username controller
                      style: TextStyle(color: Colors.purple[100], fontSize: 20),
                      decoration: myInputDecoration(
                        label: "IPASID",
                        icon: Icons.emoji_people_outlined,
                      ),
                      // keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9a-zA-Z]")),
                        LengthLimitingTextInputFormatter(11)
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ID cannot be empty";
                        } else if (value.length < 11) {
                          return "Uid must be of 11 digits";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        //set username  text on change
                        ipasid = value;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: _name, //set username controller
                      style: TextStyle(color: Colors.purple[100], fontSize: 20),
                      decoration: myInputDecoration(
                        label: "Name",
                        icon: Icons.person,
                      ),
                      // keyboardType: TextInputType.nu,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name cannot be empty";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        //set username  text on change
                        name = value;
                      },
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: _email, //set username controller
                      style: TextStyle(color: Colors.purple[100], fontSize: 20),
                      decoration: myInputDecoration(
                        label: "Email",
                        icon: Icons.email,
                      ),
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : "Please enter a valid email",
                      onChanged: (value) {
                        //set username  text on change
                        email = value;
                      },
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: _mobile, //set username controller
                      style: TextStyle(color: Colors.purple[100], fontSize: 20),
                      decoration: myInputDecoration(
                          label: "Mobile", icon: Icons.mobile_friendly),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Mobile Number cannot be empty";
                        } else if (value.length < 10) {
                          return "Number must be of 10 digits";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        //set username  text on change
                        mobile = value;
                      },
                    ),
                  ),

                  Container(
                      margin: EdgeInsets.only(right: 10, left: 10, top: 10),
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.purple[300],
                          // Colors.green,
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Color(0xffe8e8e8)),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                        style: TextStyle(color: Colors.red),
                        value: _selectedCategory,
                        items: _designation.map((item) {
                          return DropdownMenuItem(
                              child: !_isLoading
                                  ? Text(item['desig_desc'],
                                      style: TextStyle(color: Colors.black))
                                  : Text('Loading'),
                              value: !_isLoading
                                  ? item['desig_id']
                                  : Text('Loading...'));
                        }).toList(),
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                            var _isShowDesigError = false;
                            print("selected data from 40 $_selectedCategory");
                          });
                        },
                        // validator: (value){
                        //   if(value==null){
                        //     return "Designation cannot be empty";
                        //   }
                        //   return null;
                        // },
                        decoration: InputDecoration.collapsed(
                          hintText: '',
                        ),
                        hint: _designation.length > 0
                            ? Text("Select Designation")
                            : Text('Loading...'),
                        isExpanded: true,
                      ))),

                  Container(
                      margin: EdgeInsets.only(right: 10, left: 10, top: 20),
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.purple[300],
                          // Colors.green,
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Color(0xffe8e8e8)),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: DropdownButtonFormField(
                        style: TextStyle(color: Colors.black),
                        value: _selectedCategory1,
                        items: _directorate.map((item) {
                          return DropdownMenuItem(
                              child: !_isLoading
                                  ? Text(item[1],
                                      style: TextStyle(color: Colors.black))
                                  : Text('Loading'),
                              value:
                                  !_isLoading ? item[0] : Text('Loading...'));
                        }).toList(),
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory1 = value;
                            var _isShowDesigError = false;
                            print("selected data from 40 $_selectedCategory1");
                          });
                        },
                        // validator: (value){
                        //   if(value==null){
                        //     return "Department cannot be empty";
                        //   }
                        // },
                        decoration: InputDecoration.collapsed(
                          hintText: '',
                        ),

                        hint: _directorate.length > 0
                            ? Text("Select Department")
                            : Text('Loading...'),
                        isExpanded: true,
                      )),
                  // _isShowDesigError
                  //     ? Container(
                  //         margin: EdgeInsets.only(right: 20, left: 30, bottom: 10),
                  //         child: Text(
                  //           "Country of origin is required.",
                  //           style: TextStyle(color: Colors.red[800], fontSize: 12),
                  //         ),
                  //       )
                  //     : Container(),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Container(
                        color: Colors.white,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              //show progress indicator on click
                              showprogress = true;
                            });
                            Registeremp(1);
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.black54,
                            // side: BorderSide(color: Colors.pink, width: 1),
                          ),
                          child: showprogress
                              ? SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.purple[500],
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.deepPurpleAccent),
                                  ),
                                )
                              : Text(
                                  "REGISTER",
                                  style: TextStyle(fontSize: 20),
                                ),
                          // if showprogress == true then show progress indicator
                          // else show "LOGIN NOW" text
                          //  colorBrightness: Brightness.dark,
                          //  color: Colors.orange,
                          //  shape: RoundedRectangleBorder(
                          // borderRadius: BorderRadius.circular(30)
                          //button corner radius
                          //      ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            )),
            SingleChildScrollView(
                child: Form(
              key: _formKey1,
              child: Container(
                constraints:
                    BoxConstraints(minHeight: MediaQuery.of(context).size.height
                        //set minimum height equal to 100% of VH
                        ),
                width: MediaQuery.of(context).size.width,
                //make width of outer wrapper to 100%
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.purple.shade400,
                      Colors.purple.shade300,
                      Colors.purple.shade200,
                      Colors.purple.shade100,
                    ],
                  ),
                ), //show linear gradient background of page

                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Column(children: <Widget>[
                  // Container(
                  //   margin: EdgeInsets.only(top: 50),
                  //   child: Text(
                  //     "Register Employee",
                  //     style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 30,
                  //         fontWeight: FontWeight.bold),
                  //   ), //title text
                  // ),
                  Container(
                    //show error message here
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.all(10),
                    child: error ? errmsg(errormsg) : Container(),
                    //if error == true then show error message
                    //else set empty container as child
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: _ipasid1, //set username controller
                      style: TextStyle(color: Colors.purple[100], fontSize: 20),
                      decoration: myInputDecoration(
                        label: "Unique ID",
                        icon: Icons.emoji_people_outlined,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9a-zA-Z]")),
                        LengthLimitingTextInputFormatter(12)
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ID cannot be empty";
                        } else if (value.length < 10 || value.length > 12) {
                          return "Uid must be of 10-12 digits";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        //set username  text on change
                        ipasid1 = value;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: _name1, //set username controller
                      style: TextStyle(color: Colors.purple[100], fontSize: 20),
                      decoration: myInputDecoration(
                        label: "Name",
                        icon: Icons.person,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name cannot be empty";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        //set username  text on change
                        name1 = value;
                      },
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: _email1, //set username controller
                      style: TextStyle(color: Colors.purple[100], fontSize: 20),
                      decoration: myInputDecoration(
                        label: "Email",
                        icon: Icons.email,
                      ),
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : "Please enter a valid email",
                      onChanged: (value) {
                        //set username  text on change
                        email1 = value;
                      },
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: _mobile1, //set username controller
                      style: TextStyle(color: Colors.purple[100], fontSize: 20),
                      decoration: myInputDecoration(
                          label: "Mobile", icon: Icons.mobile_friendly),

                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Mobile Number cannot be empty";
                        } else if (value.length < 10) {
                          return "Number must be of 10 digits";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        //set username  text on change
                        mobile1 = value;
                      },
                    ),
                  ),

                  // Container(
                  //     margin: EdgeInsets.only(right: 10, left: 10, top: 10),
                  //     height: 70,
                  //     decoration: BoxDecoration(
                  //         color: Colors.purple[300],
                  //         // Colors.green,
                  //         shape: BoxShape.rectangle,
                  //         border: Border.all(color: Color(0xffe8e8e8)),
                  //         borderRadius: BorderRadius.all(Radius.circular(30))),
                  //     padding: EdgeInsets.all(10),
                  //     child: DropdownButtonHideUnderline(
                  //         child: DropdownButton(
                  //           style: TextStyle(color: Colors.red),
                  //           value: _selectedCategory,
                  //           items: _designation.map((item) {
                  //             return DropdownMenuItem(
                  //                 child: !_isLoading
                  //                     ? Text(item['desig_desc'],
                  //                     style: TextStyle(color: Colors.black))
                  //                     : Text('Loading'),
                  //                 value: !_isLoading
                  //                     ? item['desig_id']
                  //                     : Text('Loading...'));
                  //           }).toList(),
                  //           onChanged: (value) {
                  //             setState(() {
                  //               _selectedCategory = value;
                  //               var _isShowDesigError = false;
                  //               print("selected data from 40 $_selectedCategory");
                  //             });
                  //           },
                  //           hint: _designation.length > 0
                  //               ? Text("Select")
                  //               : Text('Loading...'),
                  //           isExpanded: true,
                  //         ))),

                  Container(
                      margin: EdgeInsets.only(right: 10, left: 10, top: 20),
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.purple[300],
                          // Colors.green,
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Color(0xffe8e8e8)),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                        style: TextStyle(color: Colors.black),
                        value: _selectedCategory2,
                        items: _directorate.map((item) {
                          return DropdownMenuItem(
                              child: !_isLoading
                                  ? Text(item[1],
                                      style: TextStyle(color: Colors.black))
                                  : Text('Loading'),
                              value:
                                  !_isLoading ? item[0] : Text('Loading...'));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory2 = value;
                            var _isShowDesigError = false;
                            print("selected data from 40 $_selectedCategory2");
                          });
                        },
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        decoration: InputDecoration.collapsed(
                          hintText: '',
                        ),
                        hint: _directorate.length > 0
                            ? Text("Select Department")
                            : Text('Loading...'),
                        isExpanded: true,
                      ))),

                  // _isShowDesigError
                  //     ? Container(
                  //         margin: EdgeInsets.only(right: 20, left: 30, bottom: 10),
                  //         child: Text(
                  //           "Country of origin is required.",
                  //           style: TextStyle(color: Colors.red[800], fontSize: 12),
                  //         ),
                  //       )
                  //     : Container(),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Container(
                        color: Colors.white,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              //show progress indicator on click
                              showprogress = true;
                            });
                            Registeremp(2);
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.black54,
                            // side: BorderSide(color: Colors.pink, width: 1),
                          ),
                          child: showprogress
                              ? SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.purple[500],
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.deepPurpleAccent),
                                  ),
                                )
                              : Text(
                                  "REGISTER",
                                  style: TextStyle(fontSize: 20),
                                ),
                          // if showprogress == true then show progress indicator
                          // else show "LOGIN NOW" text
                          //  colorBrightness: Brightness.dark,
                          //  color: Colors.orange,
                          //  shape: RoundedRectangleBorder(
                          // borderRadius: BorderRadius.circular(30)
                          //button corner radius
                          //      ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            )),
          ])),
    );
  }

  InputDecoration myInputDecoration(
      {required String label, required IconData icon}) {
    return InputDecoration(
      hintText: label, //show label as placeholder
      hintStyle:
          TextStyle(color: Colors.purple[100], fontSize: 20), //hint text style
      prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: Icon(
            icon,
            color: Colors.purple[100],
          )
          //padding and icon for prefix
          ),

      contentPadding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              color: Color(0xffe8e8e8), width: 1)), //default border of input

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              BorderSide(color: Color(0xffe8e8e8), width: 1)), //focus border

      fillColor: Color.fromRGBO(131, 33, 167, 0.5019607843137255),
      filled: true, //set true if you want to show input background
    );
  }

  Widget errmsg(String text) {
    //error message widget.
    return Container(
      padding: EdgeInsets.all(15.00),
      margin: EdgeInsets.only(bottom: 10.00),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.purple,
          border: Border.all(color: Colors.purple.shade300, width: 2)),
      child: Row(children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 6.00),
          child: Icon(Icons.info, color: Colors.white),
        ), // icon for error message

        Text(text, style: TextStyle(color: Colors.black, fontSize: 18)),
        //show error message text
      ]),
    );
  }
}
