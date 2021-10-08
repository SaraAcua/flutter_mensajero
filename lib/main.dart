import 'package:flutter/material.dart';
import 'Pantallas/lista.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Programacion Movil',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: ListaMensajeros(title: 'Proyecto Mensajeros'),
    );
  }
}
