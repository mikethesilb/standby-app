import 'package:bash_new/route_generator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(myApp());
}

Widget myApp() {
  return MaterialApp(
    title: "Bash",
    initialRoute: '/',
    onGenerateRoute: RouteGenerator.generateRoute,
  );
}
