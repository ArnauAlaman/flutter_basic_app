import 'package:basic_flutter_app/player_model.dart';
import 'package:flutter/material.dart';

class AddplayerFormPage extends StatefulWidget {
  @override
  _AddplayerFormPageState createState() => new _AddplayerFormPageState();
}

class _AddplayerFormPageState extends State<AddplayerFormPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController last_nameController = new TextEditingController();
  TextEditingController date_of_birthController = new TextEditingController();
  TextEditingController imageUrlController = new TextEditingController();

  void submitPup(BuildContext context) {
    if (nameController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        backgroundColor: Colors.redAccent,
        content: new Text('Football Players neeed names!'),
      ));
    } else {
      var newplayer = new Player(nameController.text, last_nameController.text,
          date_of_birthController.text, imageUrlController.text);
      Navigator.of(context).pop(newplayer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Add a new Football Player'),
        backgroundColor: Colors.black87,
      ),
      body: new Container(
        color: Colors.black54,
        child: new Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: new Column(children: [
            new Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: new TextField(
                controller: nameController,
                style: TextStyle(decoration: TextDecoration.none),
                //onChanged: (v) => nameController.text = v,
                decoration: new InputDecoration(labelText: 'Name the Football Player'),
              ),
            ),

            new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Builder(
                builder: (context) {
                  return new RaisedButton(
                    onPressed: () => submitPup(context),
                    color: Colors.red,
                    child: new Text('Submit Football Player'),
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
