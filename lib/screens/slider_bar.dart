import 'package:carousel_slider/carousel_slider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BankListDataModel extends Equatable {
  final String bank_name;
  final String bank_logo;

  BankListDataModel(this.bank_name, this.bank_logo);

  @override
  List<Object> get props => [bank_name, bank_logo];
}

// List<BankListDataModel> bankDataList = [
//   BankListDataModel("Đồ ăn", "assets/an.jpg"),
//   BankListDataModel("Mua heo", "assets/lon.jpg"),
//   BankListDataModel("Mua xăng", "assets/xang.jpg"),
//   BankListDataModel("Quần áo", "assets/ao.jpg"),
//   BankListDataModel("Đồ uống", "assets/uong.jpg"),
//   BankListDataModel("Game", "assets/list_icon/game.png"),
//   BankListDataModel("Du lịch", "assets/list_icon/dulich.jpg"),
//   BankListDataModel("Điện nước", "assets/list_icon/diennuoc.png"),
//   BankListDataModel("Điện thoại", "assets/list_icon/dienthoai.png"),
// ];

List<BankListDataModel> list = [
  BankListDataModel("-",
      "https://upload.wikimedia.org/wikipedia/vi/thumb/d/d0/Spider-Man-_Homecoming.JPG/220px-Spider-Man-_Homecoming.JPG"),
  BankListDataModel("--",
      "https://bizweb.dktcdn.net/100/067/696/files/coverdesk.jpg?v=1556619521593"),
  BankListDataModel("---",
      "https://upload.wikimedia.org/wikipedia/vi/thumb/d/d0/Spider-Man-_Homecoming.JPG/220px-Spider-Man-_Homecoming.JPG"),
  BankListDataModel("----",
      "https://bizweb.dktcdn.net/100/067/696/files/coverdesk.jpg?v=1556619521593"),
  BankListDataModel("-----",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTty-99wmSoUwPEJJPWz881jp5uxr29vn_FxTu6PbLbTB-L24Fk4YmQytD5EdEynrwwUz4&usqp=CAU"),
];

final List<Widget> imageSliders2 = list
    .map((item) => Container(
          child: Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius:
                    const BorderRadius.all(const Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    // Image.asset(
                    //   item.bank_logo,
                    //   width: 300.0,
                    //   height: 400.0,
                    // ),
                    Image.network(
                      item.bank_logo,
                      fit: BoxFit.cover,
                      width: 300.0,
                      height: 400.0,
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          item.bank_name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class MyHomeScreen1 extends StatefulWidget {
  @override
  State<MyHomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<MyHomeScreen1> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        flex: 9,
        child: CarouselSlider(
          items: imageSliders2,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
      ),
      Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: list.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.redAccent)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ),
    ]);
  }
}
