import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('PicNotes'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                'PicNotes',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            SizedBox(
              height: 500,
            ), 
          FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, '/camera');
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
          ],
        ),
      ),
    );
  }
}