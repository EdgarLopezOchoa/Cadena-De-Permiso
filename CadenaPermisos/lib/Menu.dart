import 'dart:math';
import 'package:cadenapermisos/CRUD_Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Menu_Body());
  }

  void DialogAddTask() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Center(
                child: Column(
                  children: [
                    TextField(
                      controller: tasknameText,
                    ),
                    TextField(
                      controller: taskdescriptionText,
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      fireStoreServices.CreateTask(
                          tasknameText.text, taskdescriptionText.text);

                      tasknameText.clear();
                      taskdescriptionText.clear();
                      Navigator.pop(context);
                    },
                    child: Text("Register"))
              ],
            ));
  }

  Widget Menu_Body() {
    return Scaffold(
      appBar: AppBar(title: Text("Requisiciones"),),
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

                  /*return ListTile(
                    title: Text(Tittle, style: TextStyle(color: Colors.black)),
                  );*/

                  return Container(
                    padding:  EdgeInsets.only(left: 0, right: 0, top: 30, bottom: 20),
                    child:
                    Column(
                        children: [
                          Text(Tittle),
                          Text(Description),
                          ElevatedButton.icon(
                            onPressed: DialogAddTask,
                            icon: const Icon(Icons.login),
                            label: const Text("Register",
                                style: TextStyle(
                                    fontSize: 18, fontFamily: "Times ", color: Colors.red)),
                          ),
                        ],
                      ),

                  );
                });
          } else {
            return Text("1");
          }
        });
  }

  Widget button() {
    return Container(
      child: ElevatedButton.icon(
        onPressed: DialogAddTask,
        icon: const Icon(Icons.login),
        label: const Text("Register",
            style: TextStyle(
                fontSize: 18, fontFamily: "Times ", color: Colors.red)),
      ),
    );
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
