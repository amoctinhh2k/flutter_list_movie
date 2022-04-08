import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp2/bloc/genres_by_movie_bloc/genres_movie_cubit.dart';
import 'package:movieapp2/bloc/theme_bloc/theme_controller.dart';
import 'package:movieapp2/model/genre.dart';
import 'package:movieapp2/repositories/movie_repository.dart';
import 'package:movieapp2/widgets/home_screen_widgets/movie_widgets_loader.dart';
import 'package:movieapp2/widgets/home_screen_widgets/movies_list_horizontal.dart';

class GenreMovieList extends StatelessWidget {
  const GenreMovieList(
      {Key? key,
      required this.themeController,
      required this.movieRepository,
      required this.genre})
      : super(key: key);
  final ThemeController themeController;
  final MovieRepository movieRepository;
  final Genre genre;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GenresMovieCubit(
        genre,
        repository: context.read<MovieRepository>(),
      )..fetchList(),
      child: GenreMovieView(
        themeController: themeController,
        movieRepository: movieRepository,
        genre: genre,
      ),
    );
  }
}

class GenreMovieView extends StatelessWidget {
  const GenreMovieView(
      {Key? key,
      required this.themeController,
      required this.movieRepository,
      required this.genre})
      : super(key: key);
  final ThemeController themeController;
  final MovieRepository movieRepository;
  final Genre genre;
  @override
  Widget build(BuildContext context) {
    final state = context.watch<GenresMovieCubit>().state;
    switch (state.status) {
      case ListStatus.failure:
        return const Center(child: Text('Có lỗi !'));
      case ListStatus.success:
        if (state.movies.isEmpty) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: const <Widget>[
                    Text(
                      "Không có Phim !",
                      style: TextStyle(color: Colors.black45),
                    )
                  ],
                )
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Thể loại ** ${genre.name}",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: MoviesListHorizontal(
              movies: state.movies,
              movieRepository: movieRepository,
              themeController: themeController,
            ),
          );
        }
      default:
        return buildMovielistLoaderWidget(context);
    }
  }
}
