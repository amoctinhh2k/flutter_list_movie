import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'rounded_input_field.dart';
import 'rounded_password_field.dart';

class Widget_Login extends StatelessWidget {
  // final Users user;
  // String passnew, pass;
  final userController = TextEditingController();
  final passController = TextEditingController();

  final hotenController = TextEditingController();

  // Widget_Login([this.user]);

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
          PasswordField(
              // onChanged: (value) {
              //   passnew = value;
              //   // (context as Element).markNeedsBuild(); // setState
              // },
              ),
          SizedBox(
            height: 20.0,
          ),
          Align(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop('dialog');
                // model.getDataSearch(meta.docs[0], context);
              },
              child: Text(
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
