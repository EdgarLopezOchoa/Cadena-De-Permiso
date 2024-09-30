import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

//My Functions
import 'Menu_Functions.dart';

class ButtonsWidgets extends StatefulWidget {
  final Menu_Functions menu_functions = Menu_Functions();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  Widget build(BuildContext context) {
    return MaterialApp();
  }

  Widget ConfimButton(
      String DocId, SharedPreferences preferences, BuildContext context) {
    int? level = preferences?.getInt("Level_User");
    if (level! >= 2) {
      return Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.1,
          child: TextButton(
            onPressed: () {
              menu_functions.ConfimAuthorization(DocId, preferences);
            },
            child: Image.asset(
              "assets/image/check.png",
            ),
            ),
          );
    } else {
      return Container();
    }
  }

  Widget SignOut(BuildContext context, String userName) {
    return Container(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
        margin: EdgeInsets.only(left: 20),
        child: Center(
          child: Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  menu_functions.SignOutLog(context);
                },
                icon: const Icon(Icons.login_rounded),
                label: const Text("Sign Out",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Times ",
                        color: Colors.black87)),
              ),
              Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    "Usuario:",
                    style: TextStyle(
                        fontFamily: "Times", fontWeight: FontWeight.bold),
                  )),
              Container(
                  child: Text(
                " $userName",
                style: TextStyle(fontFamily: "Times"),
              )),
            ],
          ),
        ));
  }
}
