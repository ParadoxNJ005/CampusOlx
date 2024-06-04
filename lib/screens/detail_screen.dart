import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatefulWidget {
  final String pimage;
  final String pname;
  final String psmalldes;
  final String pprice;
  final String oroom;
  final String ohostel;
  final String oname;
  final String onumber;
  final String pdes;
  final String orollno;

  const DetailScreen(
      {super.key,
      required this.pimage,
      required this.pname,
      required this.psmalldes,
      required this.pprice,
      required this.oroom,
      required this.ohostel,
      required this.oname,
      required this.onumber,
      required this.pdes,
      required this.orollno});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var url =
      "https://buzz.scholarshipsads.com/wp-content/uploads/2023/03/Google-Pixel-5.jpg";

  var des =
      "The Google Pixel 5, released in October 2020, is a flagship smartphone known for its clean Android experience and excellent camera performance. Featuring a 6.0-inch OLED display with a 90Hz refresh rate, it offers smooth visuals and vibrant colors. The device is powered by a Snapdragon 765G processor, coupled with 8GB of RAM and 128GB of storage, ensuring efficient performance for everyday tasks and multitasking.";
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
          color: Colors.white,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
//-------------------------------------------------image - container -----------------------------------------//

              ClipRRect(
                borderRadius:
                    BorderRadius.circular(16.0), // Adjust the radius as needed
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        16.0), // Match this radius to the container's radius
                    child: CachedNetworkImage(
                      imageUrl: widget.pimage,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

//------------------------------------------------------------------------------------------------------------//

              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.pname,
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          fontFamily: GoogleFonts.dosis().fontFamily),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.psmalldes,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          fontFamily: GoogleFonts.dosis().fontFamily),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      ("Rs.  ${widget.pprice}"),
                      style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.dosis().fontFamily),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.delivery_dining_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                              "${widget.oroom} ${widget.ohostel} , IIIT Allahabad"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Sold By",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        children: [
                          // CircleAvatar(
                          //   backgroundColor: Colors.white,
                          //   child: CircleAvatar(
                          //     backgroundColor: Color(0xffE6E6E6),
                          //     radius: 60,
                          //     child: Icon(
                          //       Icons.person,
                          //       color: Color(0xffCCCCCC),
                          //       size: 50,
                          //     ),
                          //   ),
                          // ),
                          Icon(
                            Icons.person,
                            color: Color(0xffCCCCCC),
                            size: 70,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.oname,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: GoogleFonts.dosis().fontFamily),
                              ),
                              Text(
                                "91- ${widget.onumber}",
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: GoogleFonts.dosis().fontFamily),
                              ),
                              Text(
                                "${widget.orollno}",
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: GoogleFonts.dosis().fontFamily),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 40,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Description",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(widget.pdes),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      thickness: 5,
                      color: Color.fromARGB(255, 155, 205, 165),
                      indent: 40,
                      endIndent: 40,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
