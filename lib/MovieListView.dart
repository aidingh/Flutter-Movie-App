// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackberry_code_test/MovieDetailsView.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'HeroDialogRoute.dart';
import 'MoviesModel.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie List View',
      debugShowCheckedModeBanner: false,
      home: MovieListView(),
    );
  }
}


class MovieListView extends StatefulWidget{
  @override
  _MovieListView createState() => _MovieListView();
}

class _MovieListView extends State<MovieListView>{

  List<MovieAppMovie> movieList = [];

  @override
  void initState() {
    super.initState();
    movieList = [];
    getMoviesData();
  }

  Future<List<MovieAppMovie>> getMoviesData() async{
    final String codeTestAPIUrl = "https://playground.devskills.co/api/rest/movie-app/movies";
    final response = await http.get(Uri.parse(codeTestAPIUrl));

    if(response.statusCode == 200){
      MoviesModel movieModel = new MoviesModel.fromJson(Map.from(json.decode(response.body)));
      print(movieModel.movieAppMovies[0].title);
      movieList =  movieModel.movieAppMovies;
      movieList.sort((a, b) => a.title.compareTo(b.title));
      return movieList;
    }
    else {
      throw Exception('Failed to load movies from Uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, value){
            return [
              SliverAppBar(
                title: Text("Movies",
                  style:  GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                actions: [
                  GestureDetector(
                      onTap: (){
                        print("Most rated");
                      },
                      child: Container(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10, 0.0),
                          child: Icon(Icons.local_movies_sharp, color: Colors.black, size: 36.0)),
                  ),
                ],
                leading: Icon(Icons.search_sharp, color: Colors.black, size: 36.0),
                backgroundColor: Colors.white,
                elevation: 0,
                automaticallyImplyLeading: true,
                centerTitle: true,
              )
            ];
          },
          body: Container(
            child: FutureBuilder(
              future: getMoviesData(),
              builder: (BuildContext context, AsyncSnapshot<List<MovieAppMovie>> snapshot){
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(color: Colors.black));
                }
                return CupertinoScrollbar(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {

                      /*return Card(
                          clipBehavior: Clip.antiAlias,
                          semanticContainer: true,
                          elevation: 4,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.transparent, width: 1),
                          borderRadius: BorderRadius.circular(1),
                        ),
                        child: ListTile(
                          title: Text(snapshot.data[index].title,
                            style:  GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          ),
                          subtitle: Text(snapshot.data[index].description, maxLines: 2, overflow: TextOverflow.ellipsis,
                            style:  GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          ),
                          leading: Card(
                              clipBehavior: Clip.hardEdge,
                              semanticContainer: true,
                              child: Hero(
                                  tag: snapshot.data[index].id,
                                  child: Image.network(snapshot.data[index].logo, fit: BoxFit.fill, height: 125, width: 125,))
                            ),
                          ),
                        );*/

                        return InkWell(
                          onTap: (){
                            Navigator.of(context).push(HeroDialogRoute(
                                builder: (context) {
                                  return MovieDetailsView(id: snapshot.data[index].id, title: snapshot.data[index].title, genres: "action", description: snapshot.data[index].description, logo: snapshot.data[index].logo,);
                                }
                            ));
                          },
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            semanticContainer: true,
                            elevation: 4,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.transparent, width: 1),
                              borderRadius: BorderRadius.circular(1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Card(
                                    clipBehavior: Clip.hardEdge,
                                    semanticContainer: true,
                                    child: Hero(
                                      tag: snapshot.data[index].id,
                                      child: Image.network(snapshot.data[index].logo, fit: BoxFit.fill, height: 175, width: 125,))
                                ),
                                Flexible(
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(snapshot.data[index].title,
                                          style:  GoogleFonts.lato(
                                            textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                        ),
                                      Text(snapshot.data[index].description, maxLines: 5, overflow: TextOverflow.ellipsis,
                                        style:  GoogleFonts.lato(
                                          textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}



