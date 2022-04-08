import 'package:flutter/material.dart';

import 'text_field_container.dart';

class RoundedInputPass extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  const RoundedInputPass({
    this.controller,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool _hidePassword = true;
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        obscureText: _hidePassword,
        // cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Mật khẩu",
          icon: Icon(
            Icons.lock,
            // color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: _hidePassword
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
            // color: kPrimaryColor,
            onPressed: () {
              // TODO

              print("lkkkkkk");
              _hidePassword = !_hidePassword;
              (context as Element).markNeedsBuild();
              // setState
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
