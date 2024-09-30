import 'package:cadenapermisos/Views/Menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Themes/AppThemes.dart';
import '../../main.dart';
import 'Functions_Login.dart';


class Buttons_Login extends StatefulWidget {
  Functions_Login functions_login = Functions_Login();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  Widget build(BuildContext context) {
    return MaterialApp();
  }


  Widget SignUp_Button(BuildContext context, TextEditingController nameText,
      TextEditingController passwordText) {
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 10),
      child: ElevatedButton.icon(
        onPressed: () {
          functions_login.SignUp(context, nameText, passwordText);
        },
        icon: const Icon(Icons.login),
        label: const Text("Sign Up",
            style: TextStyle(
                fontSize: 18, fontFamily: "Times ", color: Colors.red)),
      ),
    );
  }

}
