import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../CRUD.dart';


class Menu_Functions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  Widget build(BuildContext context) {
    return MaterialApp();
  }

  void SignOutLog(BuildContext context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MiApp()));
  }


  ConfimAuthorization(String DocId, SharedPreferences preferences){

    FireStoreServices fireStoreServices = FireStoreServices();

    fireStoreServices.Updateauthorization(
        DocId,
        preferences!.getString("User_Name").toString(),
        preferences!.getInt("Level_User").toString());

  }

}



