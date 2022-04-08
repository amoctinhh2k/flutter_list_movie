// import 'dart:html';

import 'dart:io';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list_movie/bloc/theme_bloc/theme_controller.dart';
import 'package:flutter_list_movie/repositories/movie_repository.dart';
import 'package:flutter_list_movie/widgets/home_screen_widgets/now_playing_widgets/now_playing_widget.dart';
import 'package:flutter_list_movie/widgets/home_screen_widgets/popular_movies_widgets/popular_movies_widget.dart';
import 'package:flutter_list_movie/widgets/home_screen_widgets/top_rated_movies_widgets/top_rated_movies_widget.dart';

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
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  var isOnline = false;
  ScrollController _rrectController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Ectrizz",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Builder(
          builder: (context) => FabCircularMenu(
            key: fabKey,
            alignment: Alignment.bottomRight,
            ringColor: Colors.white.withAlpha(25),
            ringDiameter: 300.0,
            ringWidth: 100.0,
            fabSize: 32.0,
            fabElevation: 8.0,
            fabIconBorder: CircleBorder(),
            fabColor: Colors.white,
            fabOpenIcon: const Icon(Icons.menu, color: Colors.green),
            fabCloseIcon: const Icon(Icons.close, color: Colors.green),
            fabMargin: const EdgeInsets.all(16.0),
            fabOpenColor: Colors.white,
            animationDuration: const Duration(milliseconds: 800),
            animationCurve: Curves.easeInOutCirc,
            children: <Widget>[
              Container(
                // color: Colors.blue,
                decoration:
                    BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                // decoration: ,
                child: MaterialButton(
                  onPressed: () {
                    fabKey.currentState?.close();
                  },
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(24.0),
                  child: Icon(Icons.home, color: Colors.white),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.redAccent, shape: BoxShape.circle),
                child: RawMaterialButton(
                  onPressed: () {
                    _onTapExit(context);
                  },
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(24.0),
                  child: Icon(Icons.exit_to_app, color: Colors.white),
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                child: RawMaterialButton(
                  onPressed: () {
                    // _showSnackBar(context, "Đóng menu");
                    fabKey.currentState?.close();
                  },
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(10),
                  child: Icon(Icons.transit_enterexit, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
      body: DraggableScrollbar.rrect(
        controller: _rrectController,
        backgroundColor: Colors.green,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // UpComingWidget(
            //     movieRepository: widget.movieRepository,
            //     themeController: widget.themeController),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text("TỔNG HỢP PHIM HOT",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.white,
                    color: Colors.black,
                  )),
            ),
            TopRatedMoviesWidget(
                movieRepository: widget.movieRepository,
                themeController: widget.themeController),
            const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(" PHIM NỔI BẬT",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.white,
                      color: Colors.black,
                    ))),
            SizedBox(
              height: 300,
              child: NowPlayingWidget(
                  movieRepository: widget.movieRepository,
                  themeController: widget.themeController),
            ),
            const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("XEM NGAY !",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.white,
                      color: Colors.black,
                    ))),
            PopularMoviesWidget(
                movieRepository: widget.movieRepository,
                themeController: widget.themeController),
          ],
        ),
      ),
    );
  }

  _onTapExit(
    BuildContext context,
  ) async {
    return AlertDialog(
        // title: Text("Cập nhật"),
        content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 60,
                  child: const Center(
                    child: Text('Cảnh báo',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent)),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(width: 1.0, color: Colors.black12)),
                ),
                const Center(
                  child: Text('Bạn có chắc chắn muốn Thoát !',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey)),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        color: Colors.grey,
                        child: Text('KO'),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                        },
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Colors.green,
                        child: Text(
                          'OK',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          exit(0);
                          // Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ]),
        ],
      ),
    ));
  }
}
