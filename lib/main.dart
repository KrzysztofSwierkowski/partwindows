import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'mainui.dart';



Future<void> main() async {
  // Init ffi loader if needed.
  sqfliteFfiInit();
  var databaseFactory = databaseFactoryFfi;
  String path = "Part.db";
  var db = await databaseFactory.openDatabase(path);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PartBase',
      theme: ThemeData(

        primarySwatch: Colors.indigo,
      ),
      home: const mainui(),
    );
  }
}