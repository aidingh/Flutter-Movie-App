// @dart=2.9
import 'dart:convert';

MoviesModel moviesModelFromJson(String str) => MoviesModel.fromJson(json.decode(str));

String moviesModelToJson(MoviesModel data) => json.encode(data.toJson());

class MoviesModel {
  MoviesModel({
    this.movieAppMovies,
  });

  List<MovieAppMovie> movieAppMovies;

  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
    movieAppMovies: List<MovieAppMovie>.from(json["movie_app_movies"].map((x) => MovieAppMovie.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "movie_app_movies": List<dynamic>.from(movieAppMovies.map((x) => x.toJson())),
  };
}

class MovieAppMovie {

  final int id;
  final String title;
  final String description;
  final String logo;

  MovieAppMovie({this.id, this.title, this.description, this.logo,});

  factory MovieAppMovie.fromJson(Map<String, dynamic> json) => MovieAppMovie(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "logo": logo,
  };
}