import 'package:flutter/material.dart';
import 'dart:async';
import 'player_model.dart';
import 'player_list.dart';
import 'player_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We Rate Football Players',
      theme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(
        title: 'We Rate Football Players',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Player> initialplayers = [];
  Player player = new Player("","","","");

  @override
  void initState() {
    getImageList();
    super.initState();
  }

    Future<void> getImageList() async {
      List<Player> _initialplayers = [];
      _initialplayers = await player.getImageUrl();
      setState(()  {
        initialplayers = _initialplayers;
      });
    }


  Future _showNewplayerForm() async {
    Player newplayer = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return AddplayerFormPage();
    }));
    if (newplayer != null) {
     initialplayers.add(newplayer);
    }
  }

  @override
  Widget build(BuildContext context) {
    var key = new GlobalKey<ScaffoldState>();
    return new Scaffold(
      key: key,
      appBar: new AppBar(
        title: new Text(widget.title),
        backgroundColor: Colors.black,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add),
            onPressed: _showNewplayerForm,
          ),
        ],
      ),
      body: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                .1,
                .5,
                .7,
                .9
              ],
                  colors: [
                Colors.red,
                Colors.redAccent,
                Colors.deepOrange,
                Colors.deepOrangeAccent
              ])),
          child: new Center(
            child: new playerList(initialplayers),
          )),
    );
  }
}
