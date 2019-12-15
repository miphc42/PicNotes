import 'package:flutter/material.dart';
import 'package:picnotes/home.dart';
import 'package:picnotes/camera.dart';
import 'package:picnotes/loading.dart';

void main() {
  var materialApp = MaterialApp(  
    initialRoute: '/',
    routes: {
      '/': (context)=> Loading(),
      '/home': (context) => Home(),
      '/camera': (context) => Camera(),
    },
);
  return runApp(materialApp);
}

