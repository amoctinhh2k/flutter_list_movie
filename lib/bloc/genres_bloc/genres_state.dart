part of 'genres_cubit.dart';

enum ListStatus { loading, success, failure }

// class GenresState extends Equatable {
//   const GenresState._({
//     this.status = ListStatus.loading,
//     this.movies = const <Genre>[],
//   });
//
//   const GenresState.loading() : this._();
//
//   const GenresState.success(List<Genre> movies)
//       : this._(status: ListStatus.success, movies: movies);
//
//   const GenresState.failure() : this._(status: ListStatus.failure);
//
//   final ListStatus status;
//   final List<Genre> movies;
//
//   @override
//   List<Object> get props => [status, movies];
// }

class GenresState extends Equatable {
  const GenresState._({
    this.status = ListStatus.loading,
    this.genres = const <Genre>[],
  });

  const GenresState.loading() : this._();

  const GenresState.success(List<Genre> movies)
      : this._(status: ListStatus.success, genres: movies);

  const GenresState.failure() : this._(status: ListStatus.failure);

  final ListStatus status;
  final List<Genre> genres;

  @override
  List<Object> get props => [status, genres];
}
