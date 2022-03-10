// ignore_for_file: file_names, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudflutter/additem.dart';
import 'package:flutter/material.dart';
import 'package:crudflutter/card.dart';

class Cards extends StatefulWidget {
  const Cards({Key? key}) : super(key: key);

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  final Stream<QuerySnapshot> datapeople =
      FirebaseFirestore.instance.collection('People').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Crud App'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 45, 0, 207),
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: datapeople,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something Went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('loading data');
          }
          final data = snapshot.requireData;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.size,
            itemBuilder: (context, index) {
              return Padding(
                // Column(children: [
                padding: const EdgeInsets.all(10.0),
                child: ListCard(
                    name: '${data.docs[index]['Name']}',
                    age: '${data.docs[index]['Age']}',
                    personid: snapshot.data!.docs[index].reference,
                    delete: () async {
                      await FirebaseFirestore.instance
                          .runTransaction((Transaction myTransaction) async {
                        myTransaction
                            .delete(snapshot.data!.docs[index].reference);
                      });
                    }),
                // ),D
                // ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Additem(),
            ),
          );
        },
        backgroundColor: Color.fromARGB(255, 45, 0, 207),
        child: const Icon(Icons.add),
      ),
    );
  }
}
