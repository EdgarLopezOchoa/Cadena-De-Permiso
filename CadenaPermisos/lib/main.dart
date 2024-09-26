import 'package:cadenapermisos/CRUD_Login.dart';
import 'package:cadenapermisos/Menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  SharedPreferences? preferences;

  FireStoreServices fireStoreServices = FireStoreServices();
  final TextEditingController nameText = TextEditingController();
  final TextEditingController passwordText = TextEditingController();
  final firebase_auth.FirebaseAuth aunth = FirebaseAuth.instance;

  var isObscure = true;

  @override
  void initState() {
    ChagerPreferences();

    super.initState();
  }

  void ChagerPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  void getUser() async {
    firebase_auth.User? user = aunth.currentUser;
    String? id = user?.uid;

    DocumentSnapshot snapshot =
    await FirebaseFirestore.instance.collection("users").doc(id).get();

    if (snapshot.exists) {
      preferences?.setInt("Level_User", snapshot.get("Level"));
      preferences?.setInt("Id_User", snapshot.get("Id"));
      preferences?.setString("User_Name", snapshot.get("Name"));

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Login_Body());
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
          children: <Widget>[
            Texts("LOGIN", 30.0),
            User(),
          ],
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

  Widget Email() {
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

  Widget Password() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: TextFormField(
          obscureText: isObscure,
          controller: passwordText,
          decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: isObscure
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off)),
            hintText: "Contraseña",
            border: InputBorder.none,
          )),
    );
  }

  Widget SignUp_Button() {
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 10),
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
    firebase_auth.User? user =
    await fireStoreServices.SignIn(nameText.text, passwordText.text);

    if (user != null) {
      preferences?.setString("Email", nameText.text);
      getUser();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Menu()));
    }
  }


}
