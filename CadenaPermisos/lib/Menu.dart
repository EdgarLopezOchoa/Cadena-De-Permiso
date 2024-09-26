import 'dart:math';
import 'package:cadenapermisos/CRUD_Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();




  runApp(Menu());
}

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mi App',
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Inicio> {
  final FireStoreServices auth = FireStoreServices();

  FireStoreServices fireStoreServices = FireStoreServices();
  final TextEditingController nameText = TextEditingController();
  final TextEditingController passwordText = TextEditingController();
  final TextEditingController tasknameText = TextEditingController();
  final TextEditingController taskdescriptionText = TextEditingController();

  final firebase_auth.FirebaseAuth aunth = FirebaseAuth.instance;

  SharedPreferences? preferences;

  @override
  void initState() {
    ChagerPreferences();

    super.initState();
  }




  void ChagerPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Menu_Body());
  }


  void DialogAddTask() {
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
                        controller: tasknameText,
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
                        controller: taskdescriptionText,
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
                      fireStoreServices.CreateTask(
                          tasknameText.text,
                          taskdescriptionText.text,
                          preferences!.getString("User_Name").toString());

                      tasknameText.clear();
                      taskdescriptionText.clear();
                      Navigator.pop(context);
                    },
                    child: Text("REGISTER"))
              ],
            ));
  }

  Widget Menu_Body() {
    return Scaffold(
        appBar: AppBar(
          title: Text("Requisiciones"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: DialogAddTask,
          child: const Icon(Icons.add),
        ),
        body: Tasks());
  }

  Widget Tasks() {
    return StreamBuilder(
        stream: fireStoreServices.ReadRequisition(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List listRequisition = snapshot.data!.docs;

            return ListView.builder(
                itemCount: listRequisition.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = listRequisition[index];
                  String DocId = document.id;

                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String Tittle = data['Tittle'];
                  String Description = data['Descripcion'];
                  String Autorizacion_1 = data['Autorizacion 1'];
                  String Autorizacion_2 = data['Autorizacion 2'];

                  Text Aut1 = Text("Autorizado Por: $Autorizacion_1");
                  Text Aut2 = Text("Autorizado Por: $Autorizacion_2");

                  if (Autorizacion_1 == "") {
                    Aut1 = Text(
                      "Autorizacion De Area Pendiente",
                      style: TextStyle(color: Colors.red),
                    );
                  }
                  if (Autorizacion_2 == "") {
                    Aut2 = Text(
                      "Autorizacion Gerencial Pendiente",
                      style: TextStyle(color: Colors.red),
                    );
                  }

                  /*return ListTile(
                    title: Text(Tittle, style: TextStyle(color: Colors.black)),
                  );*/

                  return Container(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 30, bottom: 20),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            Tittle,
                            style: TextStyle(
                                fontFamily: "times",
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(Description),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Aut1,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Aut2,
                        ),
                        ConfimButton(DocId),
                      ],
                    ),
                  );
                });
          } else {
            return const Text("No Task Yet");
          }
        });
  }

  Widget ConfimButton(String DocId) {
    int? level = preferences?.getInt("Level_User");
    if (level! >= 2) {
      return Container(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 10),
        child: ElevatedButton.icon(
          onPressed: () {
            fireStoreServices.Updateauthorization(
                DocId,
                preferences!.getString("User_Name").toString(),
                preferences!.getInt("Level_User").toString());
          },
          icon: const Icon(Icons.login),
          label: const Text("Comfim Action",
              style: TextStyle(
                  fontSize: 18, fontFamily: "Times ", color: Colors.black87)),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget TaskDesign(String Tittle, String Description) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(Tittle),
            Text(Description),
          ],
        ),
      ),
    );
  }
}
