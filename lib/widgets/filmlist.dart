import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:omdb_app/models/film.dart';
import 'dart:convert';
import 'detail.dart';
class Filmlist extends StatefulWidget {
  @override
  _FilmlistState createState() => _FilmlistState();
}

class _FilmlistState extends State<Filmlist> {
  //Later it will be a list of films
  List<Film> films = [];
  var filmTitleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Film app"),),
    body: 
    Padding(padding: EdgeInsets.all(10),
    child:
    Column(children: <Widget>[
      Row(children: <Widget>[
        Expanded(child:TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter a search term'
            ),
            controller: filmTitleController,
            )
            ),
        FlatButton(child: Text("Search"),
        color: Colors.blue,
        textColor: Colors.white, 
        onPressed: (){
          fetchFilms().then((newfilms){
            setState(() {
              films = newfilms;
              });
          });
        },)
      ],),
      Expanded(
  child:ListView.builder(itemBuilder: (BuildContext context, int index){
return 
Card(child: 
ListTile(
  title:Text(films[index].title), 
subtitle: Text(films[index].year),
leading: Image.network(films[index].poster),
onTap: (){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(imdbId:
   films[index].imdbId,)));

},
),
);
},
itemCount: films.length,

))
    ],
    )
    )
    ,);
  }
//<> return type, what I return in the end
// We want to return a list of films
// [] = Array = List of Object = List of films
// {} = Object = Object 
Future<List<Film>> fetchFilms() async {
  final response =  await http.get('http://www.omdbapi.com/?s=${filmTitleController.text}&apikey=87d10179');
   if (response.statusCode == 200) {
     print(response.body);
     // Transform json into object
     return Film.filmsFromJson(json.decode(response.body));
    
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
}