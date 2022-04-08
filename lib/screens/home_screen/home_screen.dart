// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:movieapp2/bloc/theme_bloc/theme_controller.dart';
import 'package:movieapp2/helpers.dart';
import 'package:movieapp2/repositories/movie_repository.dart';
import 'package:movieapp2/widgets/home_screen_widgets/now_playing_widgets/now_playing_widget.dart';
import 'package:movieapp2/widgets/home_screen_widgets/popular_movies_widgets/popular_movies_widget.dart';
import 'package:movieapp2/widgets/home_screen_widgets/top_rated_movies_widgets/top_rated_movies_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {Key? key, required this.themeController, required this.movieRepository})
      : super(key: key);

  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isOnline=false;
  @override
  Widget build(BuildContext context) {
    // isOnline =  verifyOnline() as bool;
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Ectrizz",style: TextStyle(color: Colors.white,fontSize: 25),),),),
      body:

    // if (!isOnline) {
    //   FrappeAlert.errorAlert(
    //     title: "Không có kết nối Internet",
    //     subtitle: 'Vui lòng kết nối !',
    //     context: context,
    //   );

      ListView(
        padding: EdgeInsets.zero,
        children: [
          // UpComingWidget(
          //     movieRepository: widget.movieRepository,
          //     themeController: widget.themeController),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text(
              "TỔNG HỢP PHIM HOT",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          TopRatedMoviesWidget(
              movieRepository: widget.movieRepository,
              themeController: widget.themeController),
          const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                " PHIM MỚI NHẤT",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 220,
            child: NowPlayingWidget(
                movieRepository: widget.movieRepository,
                themeController: widget.themeController),
          ),
          const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "XEM NGAY !",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          PopularMoviesWidget(
              movieRepository: widget.movieRepository,
              themeController: widget.themeController),

        ],
      )
    );
  }
}
