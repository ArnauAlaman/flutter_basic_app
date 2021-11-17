import 'package:basic_flutter_app/player_model.dart';
import 'player_detail_page.dart';
import 'package:flutter/material.dart';

class playerCard extends StatefulWidget {
  final Player player;

  playerCard(this.player);

  @override
  _playerCardState createState() => _playerCardState(player);
}

class _playerCardState extends State<playerCard> {
  Player player;
  String renderUrl;

  _playerCardState(this.player);

  void initState() {
    super.initState();
    renderplayerPic();
  }

  Widget get playerImage {
    var playerAvatar = new Hero(
      tag: player,
      child: new Container(
        width: 100.0,
        height: 100.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.cover, image: new NetworkImage(renderUrl ?? ''))),
      ),
    );

    var placeholder = new Container(
      width: 100.0,
      height: 100.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          gradient: new LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black54, Colors.black, Colors.blueGrey[600]])),
      alignment: Alignment.center,
      child: new Text(
        'PLAYER',
        textAlign: TextAlign.center,
      ),
    );

    var crossFade = new AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: playerAvatar,
      crossFadeState: renderUrl == null
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: new Duration(milliseconds: 1000),
    );

    return crossFade;
  }

  void renderplayerPic() async {
    await player.getImageUrl();
    if (mounted) {
      setState(() {
        renderUrl = player.imageUrl;
      });
    }
  }

  Widget get playerCard {
    return new Positioned(
      right: 0.0,
      child: new Container(
        width: 290,
        height: 115,
        child: new Card(
          color: Colors.black87,
          child: new Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 64),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text(
                  widget.player.name,
                  //style: Theme.of(context).textTheme.headline,
                ),
                new Text(
                  widget.player.last_name,
                  //style: Theme.of(context).textTheme.subhead,
                ),
                new Row(
                  children: <Widget>[
                    new Icon(Icons.star),
                    new Text(': ${widget.player.rating}/10')
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showplayerDetailPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return new playerDetailPage(player);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () => showplayerDetailPage(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: new Container(
          height: 115.0,
          child: new Stack(
            children: <Widget>[
              playerCard,
              new Positioned(top: 7.5, child: playerImage),
            ],
          ),
        ),
      ),
    );
  }
}
