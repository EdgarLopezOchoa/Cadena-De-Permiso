import 'package:cadenapermisos/Views/CRUD.dart';
import 'package:cadenapermisos/Views/Menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Themes/AppThemes.dart';
import '../../main.dart';
import 'ButtonsWidgets.dart';

class Menu_Objets extends StatefulWidget {
  final ButtonsWidgets buttonsWidgets = ButtonsWidgets();
  final FireStoreServices fireStoreServices = FireStoreServices();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  Widget build(BuildContext context) {
    return MaterialApp();
  }

  Widget ListTask(List listRequisition, SharedPreferences preferences) {
    return ListView.builder(
        itemCount: listRequisition.length,
        itemBuilder: (context, index) {
          DocumentSnapshot document = listRequisition[index];
          String DocId = document.id;

          Map<String, dynamic> data = document.data() as Map<String, dynamic>;

          //Items From DataBase
          String Tittle = data['Tittle'];
          String Description = data['Descripcion'];
          String Autorizacion_1 = data['Autorizacion 1'];
          String Autorizacion_2 = data['Autorizacion 2'];
          num Id_User = data["Id_User"];
          num Level_User = data["Level"];

          Container Aut1;
          Container Aut2;

          Color colors = AppThemes.colors.white;
          //Validation Authorization

          Aut1 = TextCards(
              "", "times", FontWeight.bold, 14, Colors.orange, colors);
          Aut2 = TextCards(
              "", "times", FontWeight.bold, 14, Colors.orange, colors);

          if (Autorizacion_1 == "") {
            colors = AppThemes.colors.Gold;
            Aut1 = TextCards("Autorizacion De Area Pendiente", "times",
                FontWeight.bold, 14, Colors.red, colors);
          } else {
            Aut1 = TextCards("Autorizado Por: $Autorizacion_1", "times",
                FontWeight.bold, 14, Colors.black, colors);
          }
          if (Autorizacion_2 == "") {
            colors = AppThemes.colors.Gold;
            Aut2 = TextCards("Autorizacion Gerencial Pendiente", "times",
                FontWeight.bold, 14, Colors.red, colors);
          } else {
            Aut2 = TextCards("Autorizado Por: $Autorizacion_2", "times",
                FontWeight.bold, 14, Colors.black, colors);
          }

          if (colors == AppThemes.colors.white) {
            Aut1 = TextCards("Autorizado Por: $Autorizacion_1", "times",
                FontWeight.bold, 14, Colors.orange, colors);
            Aut2 = TextCards("Autorizado Por: $Autorizacion_2", "times",
                FontWeight.bold, 14, Colors.orange, colors);
          }

          if (preferences!.getInt("Level_User")! >= Level_User &&
              Autorizacion_1 != "") {
            return CardTask(Tittle, Description, Aut1, Aut2, DocId, colors,
                preferences, context);
          } else if (preferences!.getInt("Id_User")!.toDouble() == Id_User ||
              preferences!.getInt("Level_User")! >= Level_User &&
                  preferences!.getInt("Level_User")! < 3) {
            return CardTask(Tittle, Description, Aut1, Aut2, DocId, colors,
                preferences, context);
          } else {
            return Container();
          }
        });
  }

  void SignOutLog(BuildContext context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MiApp()));
  }

  Widget CardTask(
      String Tittle,
      String Description,
      Container Aut1,
      Container Aut2,
      String DocId,
      Color CardColor,
      SharedPreferences preferences,
      BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 10),
      margin: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 0),
      child: Card(
        elevation: 3,
        color: CardColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: TextButton(
                      onPressed: () {
                        fireStoreServices.DeleteTask(DocId);
                      },
                      child: Image.asset(
                        "assets/image/xicon.png",
                      ),
                    )),
                buttonsWidgets.ConfimButton(DocId, preferences!, context),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextCards(
                  Tittle, "times", FontWeight.bold, 22, Colors.blue, CardColor),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextCards(Description, "arial", FontWeight.bold, 16,
                  Colors.black, CardColor),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Aut1,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 15,left: 15,right: 15),
              margin: EdgeInsets.only(top: 5),
              child: Aut2,
            ),
          ],
        ),
      ),
    );
  }

  TextCards(String Tittle, String FontFamily, FontWeight fontWeight,
      double fontsize, Color color, Color CardColor) {
    if (CardColor == AppThemes.colors.RedCard) {
      color = Colors.black;
    }

    return Container(
      child: Text(
        Tittle,
        style: TextStyle(
            fontFamily: FontFamily,
            fontWeight: fontWeight,
            fontSize: fontsize,
            color: color),
      ),
    );
  }
}
