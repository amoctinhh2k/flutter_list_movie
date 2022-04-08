import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BankListDataModel extends Equatable {
  final String bank_name;
  final String bank_logo;

  BankListDataModel(this.bank_name, this.bank_logo);

  @override
  List<Object> get props => [bank_name, bank_logo];
}

List<BankListDataModel> bankDataList = [
  BankListDataModel("Đồ ăn", "assets/an.jpg"),
  BankListDataModel("Mua heo", "assets/lon.jpg"),
  BankListDataModel("Mua xăng", "assets/xang.jpg"),
  BankListDataModel("Quần áo", "assets/ao.jpg"),
  BankListDataModel("Đồ uống", "assets/uong.jpg"),
  BankListDataModel("Game", "assets/list_icon/game.png"),
  BankListDataModel("Du lịch", "assets/list_icon/dulich.jpg"),
  BankListDataModel("Điện nước", "assets/list_icon/diennuoc.png"),
  BankListDataModel("Điện thoại", "assets/list_icon/dienthoai.png"),
];

class Show_Dialog extends StatefulWidget {
  const Show_Dialog({Key? key, this.context}) : super(key: key);
  final BuildContext? context;
  @override
  _Show_DialogState createState() => _Show_DialogState();
}

class _Show_DialogState extends State<Show_Dialog> {
  // final ProductStore ProductsStore = ProductStore();
  ValueNotifier<int> countCart = ValueNotifier(0);
  String date = DateTime.now().toString();
  late String _date, _name, _logo, _type;
  late BankListDataModel _bankChoose;

  // @override
  // void dispose() {
  //   print('dispose');
  //   countCart.dispose();
  //   super.dispose();
  // }

  void initState() {
    super.initState();
    _bankChoose = bankDataList[0];
    _name = _bankChoose.bank_name;
    _logo = _bankChoose.bank_logo;
  }

  void _onDropDownItemSelected(BankListDataModel newSelectedBank) {
    setState(() {
      _bankChoose = newSelectedBank;
    });
  }

  changeItem(BankListDataModel product) {
    _name = product.bank_name;
    _logo = product.bank_logo;
  }

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 1, top: 1, right: 1),
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(12, 10, 20, 20),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 16.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<BankListDataModel>(
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontFamily: "verdana_regular",
                      ),
                      items: bankDataList
                          .map<DropdownMenuItem<BankListDataModel>>(
                              (BankListDataModel value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              new CircleAvatar(
                                backgroundImage:
                                    new AssetImage(value.bank_logo),
                              ),
                              // Icon(valueItem.bank_logo),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                value.bank_name,
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      isExpanded: true,
                      isDense: true,
                      onChanged: (BankListDataModel? newSelectedBank) {
                        _onDropDownItemSelected(newSelectedBank!);
                        changeItem(_bankChoose);
                        (context as Element).markNeedsBuild();
                      },
                      value: _bankChoose,
                      dropdownMaxHeight: 180,
                      dropdownElevation: 8,
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      // offset: const Offset(-20, 0),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 15,
          )
        ]),
        Row(
          children: [
            Expanded(
              child: RaisedButton(
                color: Colors.grey,
                child: Text('Hủy'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Expanded(
              child: RaisedButton(
                color: Colors.green,
                child: Text(
                  'Lọc',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  // Get.to(ProductListSearch(
                  //   name: _name,
                  //   date: "null",
                  // ));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
