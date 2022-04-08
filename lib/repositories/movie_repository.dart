import 'package:dio/dio.dart';
import 'package:flutter_list_movie/model/cast_response.dart';
import 'package:flutter_list_movie/model/genre_response.dart';
import 'package:flutter_list_movie/model/movie_detail_response.dart';
import 'package:flutter_list_movie/model/movie_response.dart';
import 'package:flutter_list_movie/model/person_response.dart';
import 'package:flutter_list_movie/model/video_response.dart';

class MovieRepository {
  final String apiKey = "8a1227b5735a7322c4a43a461953d4ff";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();

  var getUpComingApi = '$mainUrl/movie/upcoming';
  var getPopularMoviesApi = '$mainUrl/movie/top_rated';
  var getTopRatedMoviesApi = '$mainUrl/movie/popular';
  var getNowPlayingMoviesApi = '$mainUrl/movie/now_playing';

  var getMoviesApi = '$mainUrl/movie/top_rated';
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = "$mainUrl/genre/movie/list";
  var getPersonsUrl = "$mainUrl/trending/person/week";
  var movieUrl = "$mainUrl/movie";

  Map<String, dynamic> getParams([int? page]) =>
      {"api_key": apiKey, "language": "vi-vn", if (page != null) "page": page};

  Future<MovieResponse> getMovies(int page) async {
    var params = {"api_key": apiKey, "language": "vi-vn", "page": page};
    try {
      Response response =
          await Dio().get(getMoviesApi, queryParameters: params);
      print("responseresponseresponse : " + response.data.toString());
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return MovieResponse.withError("Error: $error, StackTrace: $stacktrace");
    }
  }

  Future<MovieResponse> getPopuparMovies(int page) async {
    var params = {"api_key": apiKey, "language": "vi-vn", "page": page};
    try {
      Response response =
          await Dio().get(getPopularMoviesApi, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return MovieResponse.withError("Error: $error, StackTrace: $stacktrace");
    }
  }

  Future<MovieResponse> getNowPlaying(int page) async {
    var params = {"api_key": apiKey, "language": "vi-vn", "page": page};
    try {
      Response response =
          await Dio().get(getNowPlayingMoviesApi, queryParameters: params);
      print("Phim mới nhất ... : " + response.data.toString());
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return MovieResponse.withError("Error: $error, StackTrace: $stacktrace");
    }
  }

  Future<MovieResponse> getUpcomingMovies() async {
    var params = {"api_key": apiKey, "language": "vi-vn", "page": 1};
    try {
      Response response =
          await Dio().get(getUpComingApi, queryParameters: params);
      print("Nổi bật ... : " + response.data.toString());
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return MovieResponse.withError("Error: $error, StackTrace: $stacktrace");
    }
  }

  Future<MovieResponse> getTopRatedMovies() async {
    var params = {"api_key": apiKey, "language": "vi-vn", "page": 1};
    try {
      Response response =
          await Dio().get(getTopRatedMoviesApi, queryParameters: params);
      print("Phim hot ... : " + response.data.toString());
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return MovieResponse.withError("Error: $error, StackTrace: $stacktrace");
    }
  }

  Future<MovieResponse> getPlayingMovies() async {
    var params = {"api_key": apiKey, "language": "vi-vn", "page": 1};
    try {
      Response response =
          await Dio().get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return MovieResponse.withError("Error: $error, StackTrace: $stacktrace");
    }
  }

  Future<GenreResponse> getGenres() async {
    var params = {"api_key": apiKey, "language": "vi-vn"};
    try {
      Response response = await _dio.get(getGenresUrl, queryParameters: params);
      print("Genres : " + response.data.toString());
      return GenreResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return GenreResponse.withError("Error: $error, StackTrace: $stacktrace");
    }
  }

  Future<PersonResponse> getPersons() async {
    var params = {"api_key": apiKey};
    try {
      Response response =
          await Dio().get(getPersonsUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return PersonResponse.withError("Error: $error, StackTrace: $stacktrace");
    }
  }

  Future<MovieResponse> getMovieByGenre(int id) async {
    // var params = {
    //   "api_key": apiKey,
    //   "language": "vi-vn",
    //   "page": 1,
    //   "with_genres": id
    // };

    var params = {...getParams(), "with_genres": id};
    try {
      Response response =
          await Dio().get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return MovieResponse.withError("Error: $error, StackTrace: $stacktrace");
    }
  }

  Future<MovieDetailResponse> getMovieDetail(int id) async {
    var params = {"api_key": apiKey, "language": "vi-vn"};
    try {
      Response response =
          await Dio().get(movieUrl + "/$id", queryParameters: params);
      return MovieDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return MovieDetailResponse.withError(
          "Error: $error, StackTrace: $stacktrace");
    }
  }

  Future<VideoResponse> getMovieVideos(int id) async {
    var params = {"api_key": apiKey, "language": "vi-vn"};
    try {
      Response response = await Dio()
          .get(movieUrl + "/$id" + "/videos", queryParameters: params);
      print("Video ... : " + response.data.toString());
      return VideoResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return VideoResponse.withError("Error: $error, StackTrace: $stacktrace");
    }
  }

  Future<MovieResponse> getSimilarMovies(int id) async {
    var params = {"api_key": apiKey, "language": "vi-vn"};
    try {
      Response response = await Dio()
          .get(movieUrl + "/$id" + "/similar", queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return MovieResponse.withError("Error: $error, StackTrace: $stacktrace");
    }
  }

  Future<CastResponse> getCasts(int id) async {
    var params = {"api_key": apiKey, "language": "vi-vn"};
    try {
      Response response = await Dio()
          .get(movieUrl + "/$id" + "/credits", queryParameters: params);
      return CastResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return CastResponse.withError("Error: $error, StackTrace: $stacktrace");
    }
  }
}
