import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp2/bloc/theme_bloc/theme_controller.dart';
import 'package:movieapp2/model/genre.dart';
import 'package:movieapp2/repositories/movie_repository.dart';

import 'genre_movie_list.dart';

class GenreMovieListWidget extends StatefulWidget {
  const GenreMovieListWidget(
      {Key? key,
      required this.themeController,
      required this.movieRepository,
      required this.genre})
      : super(key: key);

  final ThemeController themeController;
  final MovieRepository movieRepository;
  final Genre genre;

  @override
  _GenreMovieListWidgetState createState() => _GenreMovieListWidgetState();
}

class _GenreMovieListWidgetState extends State<GenreMovieListWidget> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.movieRepository,
      child: GenreMovieList(
        genre: widget.genre,
        themeController: widget.themeController,
        movieRepository: widget.movieRepository,
      ),
    );
  }
}
