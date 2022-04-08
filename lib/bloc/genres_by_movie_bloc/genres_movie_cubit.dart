import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp2/model/genre.dart';
import 'package:movieapp2/model/movie.dart';
import 'package:movieapp2/repositories/movie_repository.dart';

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
