import 'dart:math';
import 'package:cadenapermisos/CRUD_Login.dart';
import 'package:cadenapermisos/Menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyADzg6EWkzTNn-1hGfnpESmiuKEsVRV1bg',
        appId: '1:730010325823:android:4be5f125359fd2407ff98a',
        messagingSenderId: 'sendid',
        projectId: 'cadena-de-permisos',
        storageBucket: 'cadena-de-permisos.appspot.com',
      ));
  runApp(MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

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

  @override
  void initState() {
    super.initState();

    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Login_Body());
  }

  void getUser() async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("users");
    QuerySnapshot users = await collectionReference.get();
    if (users.docs.isNotEmpty) {
      for (var doc in users.docs) {
        print(doc.data());
      }
    }
  }

  Widget Login_Body() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://cloud10.todocoleccion.online/calendarios-antiguos/tc/2021/04/28/20/259323095.jpg"),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Login()],
          ),
        ));
  }

  Widget Login() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: <Widget>[Texts("LOGIN", 30.0), User(),],
        ),
      ),
    );
  }

  Widget User() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 0),
      child: Center(
        child: Column(
          children: [
            Email(),
            Password(),
            SignUp_Button(),
          ],
        ),
      ),
    );
  }

  Widget Texts(String tittle, double fontSize) {
    return Text(tittle,
        style: TextStyle(
          fontFamily: "Times",
          fontWeight: FontWeight.bold,
          color: Colors.red,
          fontSize: fontSize,
        ));
  }

  Widget Email(){
    return Container(
      padding:
      const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 0),
      child: TextField(
        controller: nameText,
        decoration: InputDecoration(
            hintText: "Usuario",
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.red),
              borderRadius: BorderRadius.circular(15),
            )),
      ),
    );
  }

  Widget Password(){
    return Container(
      padding:
      const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 0),
      child: TextField(
        controller: passwordText,
        decoration: InputDecoration(
            hintText: "Contraseña",
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.red),
              borderRadius: BorderRadius.circular(15),
            )),
      ),
    );
  }

Widget SignUp_Button(){
    return Container(
      padding:
      const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 10),
      child: ElevatedButton.icon(
        onPressed: SignUp,
        icon: const Icon(Icons.login),
        label: const Text("Sign Up",
            style: TextStyle(
                fontSize: 18, fontFamily: "Times ", color: Colors.red)),
      ),
    );
}


  void SignUp() async {

    firebase_auth.User? user = await auth.SignIn(nameText.text,passwordText.text);

    if(user != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Menu()));
    }

  }
}
