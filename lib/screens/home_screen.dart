import 'package:campus_olx/screens/detail_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var url =
      "https://images.unsplash.com/photo-1493612276216-ee3925520721?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmFuZG9tfGVufDB8fDB8fHww";

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
      body: Container(
        margin: EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('sell').snapshots(),
          builder: (context, sellSnapshot) {
            if (sellSnapshot.connectionState == ConnectionState.waiting) {
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
                itemCount: sellList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 1,
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 5,
                  mainAxisSpacing: 1,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            pimage: sellList[index]['pimage'],
                            psmalldes: sellList[index]['psmalldes'],
                            pname: sellList[index]['pname'],
                            pprice: sellList[index]['pprice'],
                            oroom: sellList[index]['oroom'],
                            ohostel: sellList[index]['ohostel'],
                            oname: sellList[index]['oname'],
                            onumber: sellList[index]['onumber'],
                            pdes: sellList[index]['pdes'],
                            orollno: sellList[index]['orollno'],
                          ),
                        ),
                      );
                    },
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
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Rs. ${sellList[index]['pprice']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
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
    );
  }
}
