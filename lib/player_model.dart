import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
class Player {
  String name;
  String last_name;
  String date_of_birth;
  String imageUrl;
    String url = "https://www.mockachino.com/a5d75f8f-1eb0-43/players";
  int rating = 5;
  Player(this.name, this.last_name, this.date_of_birth, this.imageUrl);

  Future<List<Player>> getImageUrl() async {
    Map<String, dynamic> httpList;
    http.Response response = await http.get(Uri.parse(url));
    httpList = await json.decode(response.body);
    List<Player> listFootballPlayers = [];

    for (var element in httpList.values){
      Player newplayer = Player(element[0]["first_name"], element[0]["last_name"],
          element[0]["date_of_birth"], element[0]["img"]);
      listFootballPlayers.add(newplayer);
    }

    return listFootballPlayers;
  }
    /*

    try {
      var uri = new Uri.http('dog.ceo', '/api/breeds/image/random');
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      imageUrl = json.decode(responseBody)['message'];
    } catch (exception) {
      print(exception);
    }
   */


}
