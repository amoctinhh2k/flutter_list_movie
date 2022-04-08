import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp2/model/genre.dart';
import 'package:movieapp2/repositories/movie_repository.dart';

part 'genres_state.dart';

class GenresCubit extends Cubit<GenresState> {
  GenresCubit({required this.repository}) : super(const GenresState.loading());

  final MovieRepository repository;

  Future<void> fetchList() async {
    try {
      final genreResponse = await repository.getGenres();
      print("the loai : " + genreResponse.toString());
      emit(GenresState.success(genreResponse.genres));
    } on Exception {
      emit(const GenresState.failure());
    }
  }
}
