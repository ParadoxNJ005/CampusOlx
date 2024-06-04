import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> createuser(String collName, String docName, String oname,
    String onumber, String orollno, String ohostel, String oroom) async {
  await FirebaseFirestore.instance.collection(collName).doc(docName).set({
    'oname': oname,
    'ohostel': ohostel,
    'onumber': onumber,
    'orollno': orollno,
    'oroom': oroom,
  });

  Fluttertoast.showToast(msg: 'User created successfully');
}

Future<void> signup(String email, String password, String oname, String onumber,
    String orollno, String ohostel, String oroom) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    String uid = userCredential.user!.uid;

    await createuser("user", uid, oname, onumber, orollno, ohostel, oroom);

    Fluttertoast.showToast(msg: 'Successfully Signed Up and User Created.');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      Fluttertoast.showToast(msg: 'The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      Fluttertoast.showToast(msg: 'The account already exists for that email.');
    } else {
      Fluttertoast.showToast(msg: 'Failed to sign up.');
    }
  } catch (e) {
    print(e);
  }
}

signin(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    Fluttertoast.showToast(msg: 'Successfully Signed In.');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      Fluttertoast.showToast(msg: 'No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
    } else {
      Fluttertoast.showToast(msg: 'An error occurred. Please try again.');
    }
  }
}
