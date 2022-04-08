import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_list_movie/helpers.dart';

import 'rounded_input_field.dart';
import 'rounded_password_field.dart';

class Widget_Login extends StatelessWidget {
  // final Users user;
  // String passnew, pass;
  final userController = TextEditingController();
  final passController = TextEditingController();

  final hotenController = TextEditingController();

  // Widget_Login([this.user]);
  var isOnline = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          RoundedInputField(
            controller: userController,
            icon: Icons.account_circle_outlined,
            hintText: "Tài khoản",
            onChanged: (value) {},
          ),
          const PasswordField(
              // onChanged: (value) {
              //   passnew = value;
              //   // (context as Element).markNeedsBuild(); // setState
              // },
              ),
          const SizedBox(
            height: 20.0,
          ),
          Align(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () async {
                // Navigator.of(context, rootNavigator: true).pop('dialog');

                isOnline = await verifyOnline();
                if (!isOnline) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                    "Không có kết nối Internet!",
                    style: TextStyle(color: Colors.red),
                  )));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                    "Hiện tại có kết nối Internet!",
                    style: TextStyle(color: Colors.green),
                  )));
                }
              },
              child: const Text(
                'ĐĂNG NHẬP',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              color: Colors.blue,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          // Align(
          //   alignment: Alignment.center,
          //   child: RaisedButton(
          //     onPressed: () async {
          //       Navigator.of(context, rootNavigator: true).pop('dialog');
          //       // model.getDataSearch(meta.docs[0], context);
          //     },
          //     child: Text(
          //       'HỦY',
          //       style:
          //           TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          //     ),
          //     color: Colors.black12,
          //   ),
          // ),
        ],
      ),
    );
  }
}
