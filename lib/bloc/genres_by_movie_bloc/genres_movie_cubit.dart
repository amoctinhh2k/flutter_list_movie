import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_list_movie/model/genre.dart';
import 'package:flutter_list_movie/model/movie.dart';
import 'package:flutter_list_movie/repositories/movie_repository.dart';

part 'genres_movie_state.dart';

class GenresMovieCubit extends Cubit<GenresMovieState> {
  GenresMovieCubit(this.genre, {required this.repository})
      : super(const GenresMovieState.loading());

  final MovieRepository repository;
  final Genre genre;

  Future<void> fetchList() async {
    try {
      final movieResponse = await repository.getMovieByGenre(genre.id);
      emit(GenresMovieState.success(movieResponse.movies));
    } on Exception {
      emit(const GenresMovieState.failure());
    }
  }
}
