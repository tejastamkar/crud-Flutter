// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Additem extends StatefulWidget {
  const Additem({Key? key}) : super(key: key);

  @override
  State<Additem> createState() => _AdditemState();
}

class _AdditemState extends State<Additem> {
  var name, age;

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
              "Add Data",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'Enter Name of the person',
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
                labelText: 'Enter Age of the person',
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
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('People')
                      .add({'Name': name, "Age": age});

                  Fluttertoast.showToast(
                      msg: 'data is added', toastLength: Toast.LENGTH_SHORT);
                },
                icon: Icon(Icons.add),
                label: Text("Add"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
