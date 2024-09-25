import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FireStoreServices{


  CollectionReference UserCreate = FirebaseFirestore.instance.collection("users");
  CollectionReference TaskCreate = FirebaseFirestore.instance.collection("Requisicion");

  //Create user
  Future<void> CreateTask(String Tittle,String Descripcion){
    return TaskCreate.add({
      "Tittle": Tittle,
      "Descripcion":Descripcion
    });

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

}