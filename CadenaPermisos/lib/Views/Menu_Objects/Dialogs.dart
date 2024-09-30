import 'package:cadenapermisos/Views/Menu.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

//My Widgets
import '../CRUD.dart';
import 'ButtonsWidgets.dart';

class Dialogs extends StatefulWidget {
  final ButtonsWidgets buttonsWidgets = ButtonsWidgets();
  final Menu menu = Menu();
  FireStoreServices fireStoreServices = FireStoreServices();

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

  DialogAddTask(BuildContext context, TextEditingController Tittle_Controller,
      TextEditingController Description_Controller, SharedPreferences preferencesMenu) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                height: 150,
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: Tittle_Controller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Tittle",
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: Description_Controller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Description",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      ChagerPreferences();
                      fireStoreServices.CreateTask(
                          Tittle_Controller.text,
                          Description_Controller.text,
                          preferences!.getString("User_Name").toString(), preferencesMenu);

                      Tittle_Controller.clear();
                      Description_Controller.clear();
                      Navigator.pop(context);
                    },
                    child: Text("REGISTER"))
              ],
            ));
  }
}
