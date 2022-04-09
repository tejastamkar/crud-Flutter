import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crudflutter/cards.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    })),
    home: const Cards(),
  ));
}
