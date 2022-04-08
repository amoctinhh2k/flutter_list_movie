import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_list_movie/model/movie.dart';
import 'package:flutter_list_movie/repositories/movie_repository.dart';

part 'upcoming_state.dart';

class UpComingCubit extends Cubit<UpComingState> {
  UpComingCubit({required this.repository})
      : super(const UpComingState.loading());

  final MovieRepository repository;

  Future<void> fetchUpComing() async {
    try {
      final movieResponse = await repository.getUpcomingMovies();
      emit(UpComingState.success(movieResponse.movies));
    } on Exception {
      emit(const UpComingState.failure());
    }
  }
}
