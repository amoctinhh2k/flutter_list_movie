import 'package:flutter_list_movie/model/movie.dart';
import 'package:flutter_list_movie/repositories/movie_repository.dart';
import 'package:get/state_manager.dart';

class MovieController extends GetxController {
  var isLoading = true.obs;
  var productList = <Movie>[];
  late final MovieRepository repository;
  // var productList = List<Product>().obs;
  @override
  void onInit() {
    fetchMovie();
    super.onInit();
  }

  void fetchMovie() async {
    isLoading.value = true;
    var movies = await repository.getNowPlaying(1);
    productList = movies as List<Movie>;
    isLoading.value = false;
  }
}
