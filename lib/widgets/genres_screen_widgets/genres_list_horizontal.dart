import 'package:flutter/material.dart';
import 'package:flutter_list_movie/bloc/theme_bloc/theme_controller.dart';
import 'package:flutter_list_movie/model/genre.dart';
import 'package:flutter_list_movie/repositories/movie_repository.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import 'genres_by_movie_widgets/genre_movie_widget.dart';

class GenresListHorizontal extends StatefulWidget {
  const GenresListHorizontal(
      {Key? key,
      required this.genres,
      required this.themeController,
      required this.movieRepository})
      : super(key: key);

  final List<Genre> genres;
  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  State<GenresListHorizontal> createState() => _GenresListHorizontalState();
}

late VideoPlayerController _controller;

class _GenresListHorizontalState extends State<GenresListHorizontal> {
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/intro/introLogo.mp4"
        // "https://amt2020.000webhostapp.com/intro/introLogo.mp4"
        )
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text(
          "Danh sách thể loại phim",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.fill,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 8.0,
              children: List.generate(widget.genres.length, (index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10.0, left: 8.0, top: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GenreMovieListWidget(
                              themeController: widget.themeController,
                              movieRepository: widget.movieRepository,
                              genre: widget.genres[index]),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Stack(
                            children: [
                              Center(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.black87,
                                  highlightColor: Colors.white54,
                                  enabled: true,
                                  child: const SizedBox(
                                    child: Icon(
                                      FontAwesome5.film,
                                      color: Colors.black26,
                                      size: 40.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40.0,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(30.0)),
                                            color:
                                                Colors.white.withOpacity(0.1)),
                                        child: Text(
                                          widget.genres[index].name,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              height: 1.4,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
        ],
      ),
    );
  }
}
