import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_list_movie/bloc/theme_bloc/theme_controller.dart';
import 'package:flutter_list_movie/model/movie.dart';
import 'package:flutter_list_movie/repositories/movie_repository.dart';
import 'package:flutter_list_movie/screens/movie_detail_screen/movie_detail_screen.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../bloc/top_rated_movies_bloc/top_rated_movies_cubit.dart';
import '../movie_widgets_loader.dart';

class TopRatedMoviesList extends StatelessWidget {
  const TopRatedMoviesList(
      {Key? key, required this.themeController, required this.movieRepository})
      : super(key: key);
  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TopRatedCubit(
        repository: context.read<MovieRepository>(),
      )..fetchTopRated(),
      child: TopRatedMovieView(
        themeController: themeController,
        movieRepository: movieRepository,
      ),
    );
  }
}

class TopRatedMovieView extends StatelessWidget {
  const TopRatedMovieView(
      {Key? key, required this.themeController, required this.movieRepository})
      : super(key: key);
  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TopRatedCubit>().state;
    switch (state.status) {
      case ListStatus.failure:
        return const Center(child: Text('Ko có đẩy'));
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
                      "Ko có đánh giá",
                      style: TextStyle(color: Colors.black45),
                    )
                  ],
                )
              ],
            ),
          );
        } else {
          return MoviesListTop(
            movies: state.movies,
            movieRepository: movieRepository,
            themeController: themeController,
          );
        }
      default:
        return buildMovielistLoaderWidget(context);
    }
  }
}

class MoviesListTop extends StatelessWidget {
  const MoviesListTop(
      {Key? key,
      required this.movies,
      required this.themeController,
      required this.movieRepository})
      : super(key: key);

  final List<Movie> movies;
  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 150.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0, left: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(
                          themeController: themeController,
                          movieRepository: movieRepository,
                          movieId: movies[index].id),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0)),
                      child: Stack(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.black87,
                            highlightColor: Colors.white54,
                            enabled: true,
                            child: const SizedBox(
                              height: 140.0,
                              child: AspectRatio(
                                  aspectRatio: 2 / 3,
                                  child: Icon(
                                    FontAwesome5.film,
                                    color: Colors.black26,
                                    size: 40.0,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 140.0,
                            child: AspectRatio(
                                aspectRatio: 2 / 3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: FadeInImage.memoryNetwork(
                                      fit: BoxFit.cover,
                                      placeholder: kTransparentImage,
                                      image:
                                          "https://image.tmdb.org/t/p/w300/" +
                                              movies[index].poster),
                                )),
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
      ),
    );
  }
}
