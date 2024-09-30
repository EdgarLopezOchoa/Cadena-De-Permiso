import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

//My Functions
import '../CRUD.dart';
import 'Menu_Functions.dart';
import 'Menu_Objets.dart';

class DataWidgets extends StatefulWidget {

  //My functions
  final Menu_Functions menu_functions = Menu_Functions();
  FireStoreServices fireStoreServices = FireStoreServices();

  //My Widgets
  final Menu_Objets menuObjets = Menu_Objets();

  SharedPreferences? preferences;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  Widget build(BuildContext context) {
    return MaterialApp();
  }


  void ChagerPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  Widget SnapshotData(BuildContext context) {
    final ScreenSize = MediaQuery.of(context);
    Size size = ScreenSize.size;

    ChagerPreferences();

    return Container(
      width: size.width,
      height: size.height - 138,
      child: Center(
          child: StreamBuilder(
            stream: fireStoreServices.ReadRequisition(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List listRequisition = snapshot.data!.docs;

                return menuObjets.ListTask(listRequisition, preferences!);

              } else {
                return const Text("No Task Yet");
              }
            },
          )),
    );
  }

}

