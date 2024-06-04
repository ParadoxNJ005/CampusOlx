import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String oname = '';
  String orollno = '';
  late String docName;
  var liist;

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

    if (mounted) {
      setState(() {
        oname = userData['oname'] ?? '';
        orollno = userData['orollno'] ?? '';
      });
    }
  }

  var url =
      "https://images.unsplash.com/photo-1485206412256-701ccc5b93ca?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHJhbmRvbSUyMHBlb3BsZXxlbnwwfHwwfHx8MA%3D%3D";

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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage("${url}"),
                    radius: 80,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                oname,
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    fontFamily: GoogleFonts.dosis().fontFamily),
              ),
              Text(
                "${orollno}@iiita.ac.in",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    fontFamily: GoogleFonts.dosis().fontFamily),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                indent: 40,
                endIndent: 40,
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Edit Profile"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color.fromARGB(255, 123, 192, 235),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Edit Profile"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color.fromARGB(255, 123, 192, 235),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Divider(
                indent: 40,
                endIndent: 40,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Naitik")
                      .snapshots(),
                  builder: (context, sellSnapshot) {
                    if (sellSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (sellSnapshot.hasError) {
                      return Center(
                        child: Text("Something went wrong!"),
                      );
                    } else if (!sellSnapshot.hasData ||
                        sellSnapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text("No items found"),
                      );
                    } else {
                      final sellList = sellSnapshot.data!.docs;
                      return GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: sellList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 1,
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 5,
                          mainAxisSpacing: 1,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: sellList[index]['pimage'],
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      sellList[index]['pname'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "Rs. ${sellList[index]['pprice']}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(sellList[index]['psmalldes']),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
