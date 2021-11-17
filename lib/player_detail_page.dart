import 'package:flutter/material.dart';
import 'player_model.dart';
import 'dart:async';

class playerDetailPage extends StatefulWidget {
  final Player player;
  playerDetailPage(this.player);

  @override
  _playerDetailPageState createState() => new _playerDetailPageState();
}

class _playerDetailPageState extends State<playerDetailPage> {
  final double playerAvarterSize = 150.0;
  double _sliderValue = 10.0;

  Widget get addYourRating {
    return new Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Flexible(
                flex: 1,
                child: new Slider(
                  activeColor: Colors.red,
                  min: 0.0,
                  max: 10.0,
                  value: _sliderValue,
                  onChanged: (newRating) {
                    setState(() {
                      _sliderValue = newRating;
                    });
                  },
                ),
              ),
              new Container(
                width: 50.0,
                alignment: Alignment.center,
                child: new Text('${_sliderValue.toInt()}',
                    //style: Theme.of(context).textTheme.display1),
              ),
              )],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  void updateRating() {
    if (_sliderValue < 5) {
      _ratingErrorDialog();
    } else {
      setState(() {
        widget.player.rating = _sliderValue.toInt();
      });
    }
  }

  Future<Null> _ratingErrorDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('Error!'),
            content: new Text("They're good players, Brant."),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Try Again'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Widget get submitRatingButton {
    return new RaisedButton(
      onPressed: () => updateRating(),
      child: new Text('Submit'),
      color: Colors.red,
    );
  }

  Widget get playerImage {
    return new Hero(
      tag: widget.player,
      child: new Container(
        height: playerAvarterSize,
        width: playerAvarterSize,
        constraints: new BoxConstraints(),
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              const BoxShadow(
                  offset: const Offset(1.0, 2.0),
                  blurRadius: 2.0,
                  spreadRadius: -1.0,
                  color: const Color(0x33000000)),
              const BoxShadow(
                  offset: const Offset(2.0, 1.0),
                  blurRadius: 3.0,
                  spreadRadius: 0.0,
                  color: const Color(0x24000000)),
              const BoxShadow(
                  offset: const Offset(3.0, 1.0),
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                  color: const Color(0x1f000000))
            ],
            image: new DecorationImage(
                fit: BoxFit.cover,
                image: new NetworkImage(widget.player.imageUrl ?? ''))),
      ),
    );
  }

  Widget get rating {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(
          Icons.star,
          size: 40.0,
        ),
        new Text(
          '${widget.player.rating}/10',
          //style: Theme.of(context).textTheme.display2,
        )
      ],
    );
  }

  Widget get playerProfile {
    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 32.0),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [.1, .5, .7, .9],
          colors: [
            Colors.red,
            Colors.redAccent,
            Colors.deepOrange,
            Colors.deepOrangeAccent
          ],
        ),
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          playerImage,
          new Text(
            '${widget.player.name + " " + widget.player.last_name }',
            style: TextStyle(fontSize: 32.0),
          ),
          new Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: new Text("Date of birth: "+widget.player.date_of_birth),
          ),
          rating
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black87,
      appBar: new AppBar(
        backgroundColor: Colors.black87,
        title: new Text('Meet ${widget.player.name} ${widget.player.last_name}'),
      ),
      body: new ListView(
        children: <Widget>[playerProfile, addYourRating],
      ),
    );
  }
}
