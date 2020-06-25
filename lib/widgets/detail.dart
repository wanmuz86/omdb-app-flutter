import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:omdb_app/models/filmdetail.dart';
import 'dart:convert';

class DetailPage extends StatefulWidget {
  final String imdbId;
  DetailPage({this.imdbId});
  @override
  _DetailPageState createState() => _DetailPageState();

  
}

class _DetailPageState extends State<DetailPage> {
FilmDetail currentFilm;
// When the page is load - onInit() // document.ready()
  @override
  void initState() {
    fetchFilm().then((film){
setState(() {
  currentFilm = film;
});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Page"),),
      body: 
    Container(child: 
    // if it is loading, I should show Loading Indicator, else I show column - COnditional Rendering
    currentFilm == null ? Center(child: CircularProgressIndicator(),) :
    Padding(
      padding: EdgeInsets.all(10),
      child: 
    Column(
      children: <Widget>[
        Image.network(currentFilm.poster),
         SizedBox(height: 10,),
      Text(currentFilm.title, style: TextStyle(fontSize: 20,color: Colors.red),),
      SizedBox(height: 10,),
      Center(child:Text(currentFilm.plot)),
       SizedBox(height: 10,),
      Text(currentFilm.actors),
       SizedBox(height: 10,),
      Text(currentFilm.director),
    ],),),));
  }

  Future<FilmDetail> fetchFilm() async {
  final response =  await http.get('http://www.omdbapi.com/?i=${widget.imdbId}&apikey=87d10179');
   if (response.statusCode == 200) {
     print(response.body);
     // Transform json into object
     return FilmDetail.fromJson(json.decode(response.body));
    
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
}