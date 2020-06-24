class Film {
  final String imdbId;
  final String title;
  final String type;
  final String year;
  final String poster;

  // Constructor - What I call to create a new object
  Film({this.imdbId, this.title, this.type, this.year, this.poster});

  //Mapping json to Object

  factory Film.fromJson(Map<String, dynamic>json){
    return Film(
      imdbId: json["imdbID"],
      title: json["Title"],
      type: json["Type"],
      poster: json["Poster"],
      year: json["Year"]
    );
  }

  // If it is an Array, ntransform to List of Object, need to add this steps
   static List<Film> filmsFromJson(dynamic json){
     var searchResult = json["Search"];
    if (searchResult != null){
      var results = new List<Film>();
      searchResult.foreach((v){
        results.add(Film.fromJson(v));
      });
      return results;
    }
    return new List<Film>();
  }

}