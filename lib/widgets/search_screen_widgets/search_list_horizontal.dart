import 'package:flutter/material.dart';
import 'package:flutter_list_movie/bloc/theme_bloc/theme_controller.dart';
import 'package:flutter_list_movie/model/movie.dart';
import 'package:flutter_list_movie/repositories/movie_repository.dart';
import 'package:flutter_list_movie/screens/movie_detail_screen/movie_detail_screen.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_player/video_player.dart';

class SearchListHorizontal extends StatefulWidget {
  const SearchListHorizontal(
      {Key? key,
      required this.movies,
      required this.themeController,
      required this.movieRepository})
      : super(key: key);

  final List<Movie> movies;
  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  State<SearchListHorizontal> createState() => _SearchListHorizontalState();
}

class _SearchListHorizontalState extends State<SearchListHorizontal> {
  final List _list = [];

  final people = <ItemMovie>[];
  final formKey = GlobalKey<FormState>();
  var search = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late VideoPlayerController _controller;

  Future<List<Map<String, String>>> getSuggestions(
      List list, String query) async {
    await Future<void>.delayed(Duration(seconds: 1));
    List _map = [];
    for (var element in list) {
      if (element.containsKey('name')) {
        if ((element['name']!.toUpperCase())
            .toString()
            .contains(query.toUpperCase())) {
          _map.add({
            'id': element['id'],
            'name': element['name'].toString(),
            'image': element['image'].toString(),
          });
          print('=========> ${element['name']}');
        }
      }
    }
    print('Person......$query...${_map}');
    return List.generate(_map.length, (i) {
      return {
        'id': _map[i]['id'].toString(),
        'name': _map[i]['name'].toString(),
        'image': _map[i]['image'].toString()
      };
    });
  }

  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/intro/introhud.mp4"
        // "https://amt2020.000webhostapp.com/intro/introhud.mp4"
        )
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });

    print("TTTT  ${widget.movies.length}");
    widget.movies.forEach((element) {
      ItemMovie p1 = ItemMovie(element.id, element.title, element.poster);
      people.add(p1);
    });
    for (var element in people) {
      _list.add({
        'id': element.id,
        'name': element.name,
        'image': element.image,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
          title: const Text(
        "Tìm kiếm phim",
        style: TextStyle(color: Colors.white),
      )),
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.fill,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Form(
                      key: this._formKey,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: [
                                Expanded(
                                  child: TypeAheadField(
                                    direction: AxisDirection.down,
                                    noItemsFoundBuilder:
                                        (BuildContext context) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Không tìm thấy phim',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .disabledColor,
                                              fontSize: 18.0),
                                        ),
                                      );
                                    },
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                      autofocus: search,
                                      // autofocus: true,
                                      style: DefaultTextStyle.of(context)
                                          .style
                                          .copyWith(
                                              fontStyle: FontStyle.italic),
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Tên phim'),
                                    ),
                                    suggestionsCallback: (pattern) async {
                                      return await getSuggestions(
                                          _list, pattern);
                                    },
                                    itemBuilder: (context,
                                        Map<String, String> suggestion) {
                                      return ListTile(
                                        title: Container(
                                          height: 80,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: Colors.white30)),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  20)),
                                                      border: Border.all(
                                                          width: 5.0,
                                                          color:
                                                              Colors.black12)),
                                                  height: 80.0,
                                                  child: SizedBox(
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            child: FadeInImage.memoryNetwork(
                                                                fit: BoxFit
                                                                    .cover,
                                                                placeholder:
                                                                    kTransparentImage,
                                                                image: "https://image.tmdb.org/t/p/w300/" +
                                                                    suggestion[
                                                                        'image']!),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 7,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0)),
                                                  child: Stack(
                                                    children: [
                                                      Center(
                                                        child:
                                                            Shimmer.fromColors(
                                                          baseColor:
                                                              Colors.black87,
                                                          highlightColor:
                                                              Colors.white54,
                                                          enabled: true,
                                                          child: const SizedBox(
                                                            child: Icon(
                                                              FontAwesome5.film,
                                                              color: Colors
                                                                  .black26,
                                                              size: 40.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: SizedBox(
                                                          height: 40.0,
                                                          child: Center(
                                                            child: Container(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            5.0),
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              30.0)),
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.1)),
                                                                  child: Text(
                                                                    suggestion[
                                                                        'name']!,
                                                                    maxLines: 2,
                                                                    style: const TextStyle(
                                                                        height:
                                                                            1.4,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            12.0),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // subtitle: Text('\$${suggestion['image']}'),
                                      );
                                    },
                                    onSuggestionSelected:
                                        (Map<String, String> suggestion) {
                                      int id = int.parse(suggestion['id']!);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MovieDetailScreen(
                                                  themeController:
                                                      widget.themeController,
                                                  movieRepository:
                                                      widget.movieRepository,
                                                  movieId: id),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: SizedBox(),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: Lottie.network(
                                            'https://assets7.lottiefiles.com/packages/lf20_IJESD1.json',
                                            width: 50,
                                            height: 50),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            ElevatedButton(
                              child: Text('Tìm kiếm'),
                              onPressed: () {
                                setState(() {
                                  search = true;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   flex: 4,
              //   child: SizedBox(
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemMovie {
  ItemMovie(this.id, this.name, this.image);

  final String name, image;
  final int id;

  @override
  String toString() => name;
}
