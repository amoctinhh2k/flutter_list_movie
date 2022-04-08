import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:movieapp2/bloc/theme_bloc/theme_controller.dart';
import 'package:movieapp2/model/movie.dart';
import 'package:movieapp2/repositories/movie_repository.dart';
import 'package:movieapp2/screens/movie_detail_screen/movie_detail_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

class MoviesListHorizontal extends StatefulWidget {
  const MoviesListHorizontal(
      {Key? key,
      required this.movies,
      required this.themeController,
      required this.movieRepository})
      : super(key: key);

  final List<Movie> movies;
  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  State<MoviesListHorizontal> createState() => _MoviesListHorizontalState();
}

class _MoviesListHorizontalState extends State<MoviesListHorizontal> {
  @override
  Widget build(BuildContext context) {
    ScrollController _rrectController = ScrollController();
    return SizedBox(
        height: 500,
        child: DraggableScrollbar.rrect(
          controller: _rrectController,
          backgroundColor: Colors.green,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10.0, left: 8.0, top: 5.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(
                              themeController: widget.themeController,
                              movieRepository: widget.movieRepository,
                              movieId: widget.movies[index].id),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Container(
                        height: 130,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border:
                                Border.all(width: 4.0, color: Colors.white30)),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    border: Border.all(
                                        width: 5.0, color: Colors.black12)),
                                // height: 80.0,
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: FadeInImage.memoryNetwork(
                                              fit: BoxFit.cover,
                                              placeholder: kTransparentImage,
                                              image:
                                                  "https://image.tmdb.org/t/p/w300/" +
                                                      widget.movies[index].poster),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
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
                                    Center(
                                      child: SizedBox(
                                        height: 40.0,
                                        child: Center(
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5.0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius.all(
                                                                Radius.circular(
                                                                    30.0)),
                                                        color: Colors.white
                                                            .withOpacity(0.1)),
                                                    child: Text(
                                                      widget.movies[index].title,
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                          height: 1.4,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // subtitle: Text('\$${suggestion['image']}'),
                    ),
                  ),
                );
              }),
        ));
  }
}
