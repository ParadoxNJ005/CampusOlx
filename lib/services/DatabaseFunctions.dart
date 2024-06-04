import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

//---------------------------------for sell requests----------------------------------//

create(String collName, docName, pname, pimage, pcompany, pprice, psmalldes,
    pdes, oname, ohostel, onumber, oroom, orollno) async {
  await FirebaseFirestore.instance.collection(collName).doc().set({
    'pname': pname,
    'pimage': pimage,
    'pcompany': pcompany,
    'pprice': pprice,
    'psmalldes': psmalldes,
    'pdes': pdes,
    'oname': oname,
    'ohostel': ohostel,
    'onumber': onumber,
    'oroom': oroom,
    'orollno': orollno,
  });

  Fluttertoast.showToast(msg: 'created');
}

//------------------------------for user creation ------------------------------------//

createuser(String collName, docName, oname, onumber, orollno, ohostel) async {
  await FirebaseFirestore.instance.collection(collName).doc(docName).set({
    'oname': oname,
    'ohostel': ohostel,
    'onumber': onumber,
    'orollno': orollno,
  });

  Fluttertoast.showToast(msg: 'created');
}

createProductOfUser(
  String collName,
  pname,
  pimage,
  pprice,
  psmalldes,
) async {
  await FirebaseFirestore.instance.collection(collName).doc().set({
    'pname': pname,
    'pimage': pimage,
    'pprice': pprice,
    'psmalldes': psmalldes,
  });

  Fluttertoast.showToast(msg: 'created');
}

update(String collName, docName, field, var newFieldValue) async {
  await FirebaseFirestore.instance
      .collection(collName)
      .doc(docName)
      .update({field: newFieldValue});

  Fluttertoast.showToast(msg: 'updated');
}

delete(String collName, docName) async {
  await FirebaseFirestore.instance.collection(collName).doc(docName).delete();

  Fluttertoast.showToast(msg: 'Deleted');
}
