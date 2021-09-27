import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/views/datos.dart';
import 'package:learn_flutter/views/home.dart';
import 'package:learn_flutter/views/loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.done:
              return DatosView();
            default: return LoadingView();
          }
        }
      ),
    );
  }
}
