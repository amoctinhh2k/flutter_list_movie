// import 'package:flutter/material.dart';
// import 'package:fluttericon/font_awesome5_icons.dart';
// import 'package:movieapp2/bloc/theme_bloc/theme_controller.dart';
// import 'package:movieapp2/model/movie.dart';
// import 'package:movieapp2/repositories/movie_repository.dart';
// import 'package:movieapp2/screens/movie_detail_screen/movie_detail_screen.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';
// import 'package:transparent_image/transparent_image.dart';
//
// class MoviesListHorizontal extends StatefulWidget {
//   const MoviesListHorizontal(
//       {Key? key,
//       required this.movies,
//       required this.themeController,
//       required this.movieRepository})
//       : super(key: key);
//
//   final List<Movie> movies;
//   final ThemeController themeController;
//   final MovieRepository movieRepository;
//
//   @override
//   State<MoviesListHorizontal> createState() => _MoviesListHorizontalState();
// }
//
// class _MoviesListHorizontalState extends State<MoviesListHorizontal> {
//   var fruits = [];
//
//   final people = <Person>[
//     // Person('Alice', '123 Main'),
//     // Person('Bob', '456 Main')
//   ];
//   Person? selectedPerson;
//
//   final formKey = GlobalKey<FormState>();
//
//   bool autovalidate = false;
//
//   void initState() {
//     super.initState();
//     print("TTTT  ${widget.movies.length}");
//
//     widget.movies.forEach((element) {
//       print("KKKKKKKKKK" + element.title);
//       Person p1 = Person(element.title, element.poster);
//       people.add(p1);
//       fruits.add(element.title);
//     });
//
//     // Future.delayed(const Duration(milliseconds: 150), () {
//     //   fruit = fruits;
//     //   print(
//     //       "llllllllll" + fruits.length.toString() + "số1 " + fruit.toString());
//     // });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 700.0,
//       child: StreamBuilder<Object>(
//           // stream: ProductsStore.streamController,
//           builder: (context, snapshot) {
//         return Column(
//           children: [
//             Expanded(
//               flex: 5,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: widget.movies.length,
//                 itemBuilder: (context, index) {
//                   print("KKKKKKKKKK" + widget.movies[index].title);
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 10.0, left: 8.0),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => MovieDetailScreen(
//                                 themeController: widget.themeController,
//                                 movieRepository: widget.movieRepository,
//                                 movieId: widget.movies[index].id),
//                           ),
//                         );
//                       },
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(50.0)),
//                             child: Stack(
//                               children: [
//                                 Shimmer.fromColors(
//                                   baseColor: Colors.black87,
//                                   highlightColor: Colors.white54,
//                                   enabled: true,
//                                   child: const SizedBox(
//                                     height: 160.0,
//                                     child: AspectRatio(
//                                         aspectRatio: 2 / 3,
//                                         child: Icon(
//                                           FontAwesome5.film,
//                                           color: Colors.black26,
//                                           size: 40.0,
//                                         )),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 160.0,
//                                   child: AspectRatio(
//                                       aspectRatio: 2 / 3,
//                                       child: ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(5.0),
//                                         child: FadeInImage.memoryNetwork(
//                                             fit: BoxFit.cover,
//                                             placeholder: kTransparentImage,
//                                             image:
//                                                 "https://image.tmdb.org/t/p/w300/" +
//                                                     widget
//                                                         .movies[index].poster),
//                                       )),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Expanded(
//               flex: 8,
//               child: Builder(
//                 builder: (context) => Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Container(
//                     color: Colors.green,
//                     height: 50,
//                     child: Form(
//                       key: formKey,
//                       autovalidateMode: autovalidate
//                           ? AutovalidateMode.always
//                           : AutovalidateMode.disabled,
//                       child: ListView(children: <Widget>[
//                         SizedBox(height: 16.0),
//                         // Text('Selected person: "$selectedPerson"'),
//                         // Text('Selected letter: "$selectedLetter"'),
//                         SizedBox(height: 16.0),
//                         SimpleAutocompleteFormField<Person>(
//                           decoration: InputDecoration(
//                               labelText: 'Phim', border: OutlineInputBorder()),
//                           suggestionsHeight: 80.0,
//                           itemBuilder: (context, person) => Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 // Icon(Icons.shopping_cart),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5.0)),
//                                   height: 80.0,
//                                   child: AspectRatio(
//                                       aspectRatio: 2 / 3,
//                                       child: ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(5.0),
//                                         child: FadeInImage.memoryNetwork(
//                                             placeholder: kTransparentImage,
//                                             image:
//                                                 "https://image.tmdb.org/t/p/w200/" +
//                                                     person!.address.toString()),
//                                       )),
//                                 ),
//                                 Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(person!.name,
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold)),
//                                       Text(person.address)
//                                     ]),
//                               ],
//                             ),
//                           ),
//                           onSearch: (search) async => people
//                               .where((person) =>
//                                   person.name
//                                       .toLowerCase()
//                                       .contains(search.toLowerCase()) ||
//                                   person.address
//                                       .toLowerCase()
//                                       .contains(search.toLowerCase()))
//                               .toList(),
//                           itemFromString: (string) {
//                             final matches = people.where((person) =>
//                                 person.name.toLowerCase() ==
//                                 string.toLowerCase());
//                             return matches.isEmpty ? null : matches.first;
//                           },
//                           onChanged: (value) =>
//                               setState(() => selectedPerson = value),
//                           onSaved: (value) =>
//                               setState(() => selectedPerson = value),
//                           validator: (person) =>
//                               person == null ? 'Invalid person.' : null,
//                         ),
//                         SizedBox(height: 16.0),
//
//                         ElevatedButton(
//                             child: Text('Submit'),
//                             onPressed: () {
//                               if (formKey.currentState?.validate() ?? false) {
//                                 formKey.currentState!.save();
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(content: Text('Fields valid!')));
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                         content:
//                                             Text('Fix errors to continue.')));
//                                 setState(() => autovalidate = true);
//                               }
//                             })
//                       ]),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
//
// class Person {
//   Person(this.name, this.address);
//   final String name, address;
//   @override
//   String toString() => name;
// }
