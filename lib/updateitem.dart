// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Updateitems extends StatefulWidget {
  final personid;
  const Updateitems({Key? key, this.personid}) : super(key: key);

  @override
  State<Updateitems> createState() => _UpdateitemsState();
}

class _UpdateitemsState extends State<Updateitems> {
  late var name, age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Crud App'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 45, 0, 207),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
                child: Text(
              "Update Data",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'Edit Name of the person',
              ),
              onChanged: (text) {
                name = text;
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'Edit Age of the person',
              ),
              onChanged: (text) {
                age = text;
              },
            ),
            SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .runTransaction((Transaction myTransaction) async {
                    myTransaction
                        .update(widget.personid, {'Name': name, "Age": age});
                  });

                  Fluttertoast.showToast(
                      msg: 'data is updated', toastLength: Toast.LENGTH_SHORT);
                },
                icon: Icon(Icons.update),
                label: Text("Update"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
