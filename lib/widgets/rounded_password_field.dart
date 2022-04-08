import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'text_field_container.dart';

class PasswordField extends StatefulWidget {
  // final String pass;
  final ValueChanged<String>? onChanged;
  const PasswordField({
    this.onChanged,

    // this.pass,
  });
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: FormBuilderTextField(
        maxLines: 1,
        // name: 'pwd',
        // // initialValue: widget.pass,
        // validator: FormBuilderValidators.compose([
        //   FormBuilderValidators.required(context),
        // ]),
        // onChanged: widget.onChanged,
        obscureText: _hidePassword,
        // cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Mật khẩu",
          icon: Icon(
            Icons.lock,
          ),
          suffixIcon: IconButton(
            icon: _hidePassword
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
            onPressed: () {
              setState(
                () {
                  // TODO
                  print("lkkkkkk");
                  _hidePassword = !_hidePassword;
                },
              );
            },
          ),
          border: InputBorder.none,
        ),
        name: '',
      ),
    );
  }
}
