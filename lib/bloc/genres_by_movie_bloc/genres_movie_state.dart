part of 'genres_movie_cubit.dart';

enum ListStatus { loading, success, failure }

class GenresMovieState extends Equatable {
  const GenresMovieState._({
    this.status = ListStatus.loading,
    this.movies = const <Movie>[],
  });

  const GenresMovieState.loading() : this._();

  const GenresMovieState.success(List<Movie> movies)
      : this._(status: ListStatus.success, movies: movies);

  const GenresMovieState.failure() : this._(status: ListStatus.failure);

  final ListStatus status;
  final List<Movie> movies;

  @override
  List<Object> get props => [status, movies];
}
