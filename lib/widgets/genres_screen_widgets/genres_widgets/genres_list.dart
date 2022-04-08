import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp2/bloc/genres_bloc/genres_cubit.dart';
import 'package:movieapp2/bloc/theme_bloc/theme_controller.dart';
import 'package:movieapp2/repositories/movie_repository.dart';
import 'package:movieapp2/widgets/genres_screen_widgets/genres_list_horizontal.dart';
import 'package:movieapp2/widgets/home_screen_widgets/movie_widgets_loader.dart';

class GenresList extends StatelessWidget {
  const GenresList(
      {Key? key, required this.themeController, required this.movieRepository})
      : super(key: key);
  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GenresCubit(
        repository: context.read<MovieRepository>(),
      )..fetchList(),
      child: GenresView(
        themeController: themeController,
        movieRepository: movieRepository,
      ),
    );
  }
}

class GenresView extends StatelessWidget {
  const GenresView(
      {Key? key, required this.themeController, required this.movieRepository})
      : super(key: key);
  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GenresCubit>().state;
    switch (state.status) {
      case ListStatus.failure:
        return const Center(child: Text('Có lỗi !'));
      case ListStatus.success:
        if (state.genres.isEmpty) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: const <Widget>[
                    Text(
                      "Không có báo ",
                      style: TextStyle(color: Colors.black45),
                    )
                  ],
                )
              ],
            ),
          );
        } else {
          return GenresListHorizontal(
            genres: state.genres,
            movieRepository: movieRepository,
            themeController: themeController,
          );
        }
      default:
        return buildMovielistLoaderWidget(context);
    }
  }
}
