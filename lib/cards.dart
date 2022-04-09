// ignore_for_file: file_names, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudflutter/additem.dart';
import 'package:crudflutter/scanner.dart';
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

  int index = 0;

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
          // setState(() {
          //   index = data.size;
          // });
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.size,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                child: Padding(
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
                ),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 45, 0, 207),
            ),
            onPressed: () {
              Navigator.of(context).push(_createRoute());
            },
            child: Text('Next Page')),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Scanner(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
