import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage2 extends StatefulWidget {
  @override
  State<HomePage2> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  TextEditingController c = TextEditingController();
  bool _isLoading = true;
  late String removeStatus;

  final List _userRoles = [];
  Future _getUserRole() async {
    List data = [];
    http.Response response;
    String api = "https://hello-259.herokuapp.com/rdso/complaint"; //api url
    response = await http.get(Uri.parse(api));
    var responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      if (responseData.isNotEmpty) {
        for (var i = 0; i < responseData.length; i++) {
          data.add(responseData[i]);
        }
        //print(data);

        setState(() {
          _userRoles.addAll(data);
          _isLoading = false;
        });
      } else {
        _isLoading = false;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserRole();
    _isLoading = true;
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            columns: const [
              DataColumn(
                  label: Text(
                'Complaint ID',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                'Complaint Number',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                'Complaint Description',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                'Status Flag',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                'Escalated',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                'Remarks',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ],
            rows: _userRoles
                .map(
                  (userRole) => DataRow(cells: [
                    DataCell(Text(userRole["complaint_id"].toString())),
                    DataCell(Text(userRole["complaint_no"].toString())),
                    DataCell(
                        Text(userRole["complaint_description"].toString())),
                    DataCell(Text(userRole["status_flag"].toString())),
                    DataCell(Text(userRole["escalated"].toString())),
                    DataCell(
                      (c.text == "")
                          ? TextButton(
                              child: Text("Edit"),
                              onPressed: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Remark'),
                                      content: TextField(
                                        controller: c,
                                        decoration: InputDecoration(
                                            hintText: 'Enter Remark'),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          child: const Text("Submit"),
                                          onPressed: () {
                                            setState(() {
                                              Navigator.pop(context);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              },
                            )
                          : Text(c.text),
                    ),
                  ]),
                )
                .toList()),
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Remark'),
          content: TextField(
            controller: c,
            decoration: InputDecoration(hintText: 'Enter Remark'),
          ),
          actions: [
            ElevatedButton(
              child: const Text("Submit"),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.red),
        title: const Text(
          "Complain Lodge",
          style: TextStyle(color: Color.fromARGB(255, 246, 68, 33)),
        ),
      ),
      body: (_isLoading)
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(children: [
                _dataBody(),
              ]),
            ),
    );
  }
}
