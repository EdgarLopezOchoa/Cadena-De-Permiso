import 'package:cadenapermisos/Views/CRUD.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//My Widgets
import 'Menu_Objects/ButtonsWidgets.dart';
import 'Menu_Objects/Menu_Objets.dart';
import 'Menu_Objects/DataWidgets.dart';
import 'Menu_Objects/Dialogs.dart';

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
  //DataBase References
  final FireStoreServices auth = FireStoreServices();
  final firebase_auth.FirebaseAuth aunth = FirebaseAuth.instance;

  FireStoreServices fireStoreServices = FireStoreServices();

  //Items Reference
  final TextEditingController nameText = TextEditingController();
  final TextEditingController passwordText = TextEditingController();
  final TextEditingController tasknameText = TextEditingController();
  final TextEditingController taskdescriptionText = TextEditingController();

  //Widgets References
  final ButtonsWidgets buttonsWidgets = ButtonsWidgets();
  final Menu_Objets menuObjets = Menu_Objets();
  final DataWidgets dataWidgets = DataWidgets();
  final Dialogs dialogs = Dialogs();

  //Credential storage
  SharedPreferences? preferences;
  String User_Name = "";

  @override
  void initState() {
    ChagerPreferences();
    super.initState();
  }

  void ChagerPreferences() async {
    preferences = await SharedPreferences.getInstance();
    User_Name = preferences!.getString("User_Name")!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Menu_Body());
  }

  //AlertDialog To Create a New Task

  Widget Menu_Body() {
    return Scaffold(
        appBar: AppBar(
          title: Text("Requisiciones"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:() {
            dialogs.DialogAddTask(context, tasknameText, taskdescriptionText, preferences!);
          }
            ,
          child: const Icon(Icons.add),
        ),
        body: Tasks());
  }

  //Function to Search Task in Database
  Widget Tasks() {
    return Container(
        child: Center(
      child: Column(
        children: [
          buttonsWidgets.SignOut(context, User_Name),
          dataWidgets.SnapshotData(context),
        ],
      ),
    ));
  }
}
