import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainMenu extends StatefulWidget {
  final String uid;
  final String value;
  MainMenu({Key key, @required this.uid, @required this.value}) : super(key: key);
  @override
  _MainMenuState createState() => _MainMenuState(uid,value);
}

class _MainMenuState extends State<MainMenu> {
  final String uid;
  final String value;
  _MainMenuState(this.uid,this.value);
  String url = "http://103.212.88.139:9000/";
  var urll;
  void getname() async {
    var send = await http.post(url, body: json.encode({'name': uid,'value':int.parse(value)}));
    final decode = json.decode(send.body);
    final decode2 = json.decode(decode);
    setState(() {
      urll = decode2['url'];
    });
  }

  @override
  void initState() {
    super.initState();
    getname();
  }

  @override
  Widget build(BuildContext context) {
    if (urll == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blue[900], Colors.pink[300]]),
              ),
              child: Column(children: [
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText('$uid',maxLines: 1,
                      style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 30)),
                ),
                Container(
                    height: 600,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: ListView.builder(
                      itemCount:urll.length,
                      itemBuilder: (context, index) {
                        return Card(
                            point: urll[index],
                            );
                      },
                    ))
              ])));
    }
  }
}

class Card extends StatelessWidget {
  final String point;

  Card(
      {Key key,
      @required this.point,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.0),
        child: Container(
            child: Column(
              children: [
                SizedBox(height: 30),
                Image.network(point)
                              ],
            )));
  }
}
