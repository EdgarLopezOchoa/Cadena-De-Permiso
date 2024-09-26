import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireStoreServices{


  CollectionReference UserCreate = FirebaseFirestore.instance.collection("users");
  CollectionReference TaskCreate = FirebaseFirestore.instance.collection("Requisicion");
  SharedPreferences? preferences;

  //Create user
  Future<void> CreateTask(String Tittle,String Descripcion,String Name){

    if(preferences?.getInt("Level_User") == 2){
      return TaskCreate.add({
        "Tittle": Tittle,
        "Descripcion":Descripcion,
        "Autorizacion 1": Name,
        "Autorizacion 2": ""
      });

    }else if(preferences?.getInt("Level_User") == 3){
      return TaskCreate.add({
        "Tittle": Tittle,
        "Descripcion":Descripcion,
        "Autorizacion 1": "",
        "Autorizacion 2": Name
      });
    }

      return TaskCreate.add({
        "Tittle": Tittle,
        "Descripcion":Descripcion,
        "Autorizacion 1": "",
        "Autorizacion 2": ""
      });

  }


  void ChagerPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<User?> SignIn(String email, String password) async{
    FirebaseAuth auth = FirebaseAuth.instance;

    UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;

  }

  Future<User?> SignUp(String email, String password) async{
    FirebaseAuth auth = FirebaseAuth.instance;

    UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;

  }

  Stream<QuerySnapshot> ReadRequisition(){
    final Requisition = TaskCreate.orderBy("Tittle",descending: true).snapshots();
    return Requisition;
    
    
  }


  Future<void> Updateauthorization(String DocId,String Name, String Level) {
    if (Level! == "2") {
      return TaskCreate.doc(DocId).update({
        "Autorizacion 1": Name,
      });
    } else {
      return TaskCreate.doc(DocId).update({
        "Autorizacion 2": Name,
      });
    }
  }
}