class FilmDetail {
  final String imdbId;
  final String title;
  final String poster;
  final String director;
  final String plot;
  final String actors;

  FilmDetail({this.imdbId, this.title, this.poster, this.director, this.plot,
   this.actors});

   factory FilmDetail.fromJson(Map<String, dynamic>json){
     return FilmDetail(poster: 
     json["Poster"],
     title:json["Title"],
     director: json["Director"],
     plot:json["Plot"],
     actors: json["Actors"]
     );
   }

}

