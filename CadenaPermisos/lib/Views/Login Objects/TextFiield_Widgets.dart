import 'package:cadenapermisos/Views/Menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Themes/AppThemes.dart';
import '../../main.dart';

class TextField_Widgets extends StatefulWidget {

  var isObscure = true;


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  Widget build(BuildContext context) {
    return MaterialApp();
  }

  Widget Email(TextEditingController nameText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: nameText,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "E-mail",
        ),
      ),
    );
  }


}
