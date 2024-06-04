import 'package:campus_olx/services/DatabaseFunctions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _formKey = GlobalKey<FormState>();

  String pname = '';
  String pimage = '';
  String pcompany = '';
  String pprice = '';
  String psmalldes = '';
  String oname = '';
  String ohostel = '';
  String onumber = '';
  String oroom = '';
  String pdes = '';
  String orollno = '';
  late String docName;
  final String collName = "sell";

  final ImagePicker _picker = ImagePicker();
  XFile? file;

  @override
  void initState() {
    super.initState();
    docName = FirebaseAuth.instance.currentUser!.uid;
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('user').doc(docName).get();
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

    setState(() {
      oname = userData['oname'] ?? '';
      ohostel = userData['ohostel'] ?? '';
      onumber = userData['onumber'] ?? '';
      orollno = userData['orollno'] ?? '';
      oroom = userData['oroom'] ?? '';
    });
  }

  Future<String> uploadImage(XFile image) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("product_images/${image.name}");
    UploadTask uploadTask = ref.putFile(File(image.path));
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Olx",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.green.shade300,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout_rounded),
            color: Colors.black,
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 350,
            child: Card(
              elevation: 5,
              color: Color.fromARGB(255, 253, 250, 250),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      //-----------------------------------------------Image Picker---------------------------------------------------//
                      Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.white,
                        child: Center(
                          child: file == null
                              ? Text('Image Not Picked')
                              : Image.file(
                                  File(file!.path),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      //-------------------------------------------Image - Picker Button -------------------------------------------//

                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor:
                                  Color.fromARGB(255, 123, 192, 235)),
                          onPressed: () async {
                            final XFile? photo = await _picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              file = photo;
                            });

                            if (photo != null) {
                              print('Image Picked');
                            }
                          },
                          child: Text(
                            'Pick Image',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      //---------------------------------------details upload form --------------------------------------------------//
                      SizedBox(height: 20),
                      TextFormField(
                        key: ValueKey('pname'),
                        decoration:
                            InputDecoration(hintText: "Enter Product Name"),
                        validator: (value) {
                          if (value.toString().length < 3) {
                            return 'Name is too short';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            pname = value!;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        key: ValueKey('pcompany'),
                        decoration:
                            InputDecoration(hintText: "Enter Company Name"),
                        validator: (value) {},
                        onSaved: (value) {
                          setState(() {
                            pcompany = value!;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        key: ValueKey('smalldes'),
                        decoration: InputDecoration(
                            hintText: "Enter Small description"),
                        validator: (value) {
                          if (value.toString().length > 25) {
                            return 'description is too big';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            psmalldes = value!;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        key: ValueKey('price'),
                        decoration:
                            InputDecoration(hintText: "Enter Expected Price"),
                        validator: (value) {},
                        onSaved: (value) {
                          setState(() {
                            pprice = value!;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        key: ValueKey('detail'),
                        decoration:
                            InputDecoration(hintText: "Enter Product Details"),
                        validator: (value) {},
                        onSaved: (value) {
                          setState(() {
                            pdes = value!;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (file != null) {
                              pimage = await uploadImage(file!);
                            }
                            _formKey.currentState!.save();
                            create(
                                collName,
                                docName,
                                pname,
                                pimage,
                                pcompany,
                                pprice,
                                psmalldes,
                                pdes,
                                oname,
                                ohostel,
                                onumber,
                                oroom,
                                orollno);
                            createProductOfUser(
                                oname, pname, pimage, pprice, psmalldes);
                          },
                          child: Text(
                            "Upload",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor:
                                  Color.fromARGB(255, 123, 192, 235)),
                        ),
                      ),

                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
