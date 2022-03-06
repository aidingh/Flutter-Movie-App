// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'MoviesModel.dart';

class MovieDetailsView extends StatefulWidget{

  final int id;
  final String title;
  final String genres;
  final String description;
  final String logo;

  MovieDetailsView({Key key, this.id, this.title, this.genres, this.description, this.logo}): super(key: key);

  @override
  _MovieDetailsView createState() => _MovieDetailsView();
}

class _MovieDetailsView extends State<MovieDetailsView>{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setRatingValue());
  }

  setRatingValue(){

  }

  Widget movieImageDetail(){
    var appSize = MediaQuery.of(context).size;
    return Container(
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.transparent, width: 0.5),
          borderRadius: BorderRadius.circular(2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1.8),
          child: Hero(
            tag: widget.id,
            child: Image.network(widget.logo,
              fit: BoxFit.fill,
            ),
          )
        ),
      ),
    );
  }

  Widget movieTitleDetail(){
    return Container(
      child: Text(widget.title,
        style: GoogleFonts.lato(
          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }

  Widget movieGenreDetail(){
    return Container(
      child: Text(widget.genres,
        style: GoogleFonts.lato(
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }

  Widget movieRatingDetail(){
    return Container(
      child: RatingBar.builder(
        initialRating: 4,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemSize: 25.0,
        itemCount: 10,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (double value) {

        },
      ),
    );
  }

  Widget movieDescriptionDetail(){
    return Container(
      child: Text(widget.description,
        style: GoogleFonts.lato(
          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
        ),
      ),
    );
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
                title: Text(widget.title,
                  style:  GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                actions: [
                  GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10, 0.0),
                          child: Icon(Icons.movie_filter_sharp, color: Colors.black, size: 36.0)),
                  ),
                ],
                leading: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_sharp, color: Colors.black, size: 36.0)),
                backgroundColor: Colors.white,
                elevation: 5,
                automaticallyImplyLeading: true,
                centerTitle: true,

              )
            ];
          },
          body: CupertinoScrollbar(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  movieImageDetail(),
                  movieTitleDetail(),
                  movieGenreDetail(),
                  movieRatingDetail(),
                  movieDescriptionDetail()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

