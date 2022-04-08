import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:intl/intl.dart';
import 'package:movieapp2/bloc/theme_bloc/theme_controller.dart';
import 'package:movieapp2/bloc/upcoming_bloc/upcoming_cubit.dart';
import 'package:movieapp2/repositories/movie_repository.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

import 'upcoming_loader.dart';

class UpComingSlider extends StatelessWidget {
  const UpComingSlider(
      {Key? key, required this.themeController, required this.movieRepository});

  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UpComingCubit(
        repository: context.read<MovieRepository>(),
      )..fetchUpComing(),
      child: UpComingView(
          movieRepository: movieRepository, themeController: themeController),
    );
  }
}

class UpComingView extends StatefulWidget {
  const UpComingView(
      {Key? key, required this.themeController, required this.movieRepository});

  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  State<UpComingView> createState() => _UpComingViewState();
}

class _UpComingViewState extends State<UpComingView> {
  var inputFormat = DateFormat('yyyy-MM-dd');
  var outputFormat = DateFormat('dd/MM/yyyy');
  String? outputDate = "";

  void initState() {}

  @override
  Widget build(BuildContext context) {
    final state = context.watch<UpComingCubit>().state;
    switch (state.status) {
      case ListStatus.failure:
        return const Center(child: Text('Có lỗi '));
      case ListStatus.success:
        return Column(
          children: [
            Positioned(
                left: 10.0,
                top: 10.0,
                child: SafeArea(
                  child: Text(
                    " Ectrizz",
                    style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 18.0,
                        color: Colors.white.withOpacity(0.5)),
                  ),
                )),
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: false,
                    viewportFraction: 1.0,
                    aspectRatio: 3.5 / 2.8,
                    enlargeCenterPage: true,
                  ),
                  items: state.movies
                      .map((movie) => Stack(
                            children: [
                              Stack(
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.black87,
                                    highlightColor: Colors.white54,
                                    enabled: true,
                                    child: const AspectRatio(
                                        aspectRatio: 6 / 2.8,
                                        child: Icon(
                                          FontAwesome5.film,
                                          color: Colors.black26,
                                          size: 40.0,
                                        )),
                                  ),
                                  Column(
                                    children: [
                                      Expanded(
                                        child: AspectRatio(
                                          aspectRatio: 4.2 / 2.8,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            child: FadeInImage.memoryNetwork(
                                                fit: BoxFit.fitHeight,
                                                alignment:
                                                    Alignment.bottomCenter,
                                                placeholder: kTransparentImage,
                                                // height: 200,
                                                image:
                                                    "https://image.tmdb.org/t/p/original/" +
                                                        movie.poster),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Positioned(
                                          top: 10.0,
                                          right: 10.0,
                                          child: SafeArea(
                                            child: Text(
                                              "Ngày phát hành : " +
                                                  outputFormat.format(
                                                      inputFormat.parse(
                                                          movie.releaseDate)) +
                                                  "  ",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0,
                                                  color: Colors.white),
                                            ),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ],
            ),
            Positioned(
                left: 10.0,
                top: 10.0,
                child: SafeArea(
                  child: Text(
                    "-------",
                    style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 18.0,
                        color: Colors.white.withOpacity(0.5)),
                  ),
                )),
          ],
        );
      default:
        return buildLoadingCampaignsWidget(context);
    }
  }
}
