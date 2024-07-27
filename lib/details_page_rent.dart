import 'package:akarna/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home.dart';

class DetailsPageRent extends StatefulWidget
{
  const DetailsPageRent({super.key, required this.email, required this.product, required this.index,required this.status});
  final List<dynamic> product;
  final String email;
  final int index;
  final String status;

  @override
  State<DetailsPageRent> createState() => _DetailsPageRentState();
}

class _DetailsPageRentState extends State<DetailsPageRent>
{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<dynamic> rents = [];
  bool isRented = true;

  fetchRents() async
  {
    QuerySnapshot qn = await _firestore.collection('rents').get();
    setState(()
    {
      for (int i = 0; i < qn.docs.length; i++)
      {
        rents.add({
          'email': qn.docs[i]['email'],
          'imageUrl': qn.docs[i]['imageUrl'],
          'price': qn.docs[i]['price'],
          'location': qn.docs[i]['location'],
          'isRented': qn.docs[i]['isRented'],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState()
  {
    super.initState();
    fetchRents();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),
            Padding(
              padding: const EdgeInsets.only(right: 330),
              child: IconButton(  onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back),color: Colors.black,),
            ),

            Image.network(
              widget.product[widget.index]["imageURL"],fit: BoxFit.contain,
              height: 280,
              width: MediaQuery.of(context).size.width,
            ),





            SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [

                  Icon(CupertinoIcons.star_fill,color: Colors.green,),
                  Icon(CupertinoIcons.star_fill,color: Colors.green,),
                  Icon(CupertinoIcons.star_fill,color: Colors.green,),
                  Icon(CupertinoIcons.star_fill,color: Colors.green,),
                  Icon(CupertinoIcons.star_lefthalf_fill,color: Colors.green,),
                  SizedBox(width: MediaQuery.sizeOf(context).width*0.15,),
                  Text("${widget.product[widget.index]['price']} Egp",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ],

              ),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(widget.product[widget.index]['Name'],style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(width: MediaQuery.sizeOf(context).width*0.20,),
                  const Icon(CupertinoIcons.location_solid,color: Colors.green,),
                  Column(
                    children: [
                      Text( widget.product[widget.index]['location']),
                    ],
                  )
                ],


              ),

            ),
            SizedBox(height: MediaQuery.sizeOf(context).height*0.03,),
            Container(
              width: 320,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.green
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0,left: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
                      ],
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),
                    Row(
                      children: [
                        Text("Space(m^2) :"+ widget.product[widget.index]["space"].toString(),style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    Row(
                      children: [
                        Text("Bedrooms :"+ widget.product[widget.index]["bed"].toString(),style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    Row(
                      children: [
                        Text("Bathrooms :"+ widget.product[widget.index]["bath"].toString(),style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    Row(
                      children: [
                        Text("Price :"+ widget.product[widget.index]["price"].toString()+" Egp",style: TextStyle(color: Colors.white),)
                      ],
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 10,),
            Padding(

              padding: const EdgeInsets.only(top: 10.0,left: 22),
              child: Row(
                children: [
                 Text("Description" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                ],
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(top: 10.0,left: 22),
              child: Row(
                children: [
                  Container(
                      width:250,
                      height:100 ,
                      child: Text( widget.product[widget.index]['description']))
                ],
              ),
            ),
            SizedBox(height:30,),
            FloatingActionButton.extended(
              backgroundColor: Colors.green,
              label: Text(rents.isEmpty ? 'Rent' : (rents.any((map) => map['imageUrl'] == widget.product[widget.index]['imageURL']) ? 'Rented' : 'Rent'),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
              onPressed: () async
              {
                if(rents.isNotEmpty)
                {
                  if((rents.any((map) => map['imageUrl'] == widget.product[widget.index]['imageURL']) ) == false )
                  { QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                      .collection('users') // Replace with your collection name
                      .where('email', isEqualTo: widget.email)
                      .get();

                    DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
                     String docId = documentSnapshot.id;
                     int currentBalance = documentSnapshot['balance'];
                    if (currentBalance >= widget.product[widget.index]['price']) {
                    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
                    await firebaseFirestore.collection('rents').add({
                      'email': widget.email,
                      'imageUrl': widget.product[widget.index]['imageURL'],
                      'price': widget.product[widget.index]['price'],
                      'location': widget.product[widget.index]['location'],
                      'isRented': true,
                    });
                    await firebaseFirestore.collection('Activities').add(
                        {
                          'email': widget.email,
                          'imageUrl': widget.product[widget
                              .index]['imageURL'],
                          'price': '-${widget.product[widget.index]['price']} EGP',
                          'location': widget.product[widget
                              .index]['location'],
                        });


                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(docId)
                        .update({'balance': currentBalance - widget.product[widget.index]['price']});

                    Fluttertoast.showToast(msg: 'Successful Rent');
                   
                    setState(() {});}
                    else{
                    Fluttertoast.showToast(msg: 'no enough balance');
                  }
                  }
                }


                else
                {
                  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                      .collection('users') // Replace with your collection name
                      .where('email', isEqualTo: widget.email)
                      .get();

                  DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
                  String docId = documentSnapshot.id;
                  int currentBalance = documentSnapshot['balance'];
                  if (currentBalance >= widget.product[widget.index]['price']) {
                  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
                  await firebaseFirestore.collection('rents').add({
                    'email': widget.email,
                    'imageUrl': widget.product[widget.index]['imageURL'],
                    'price': widget.product[widget.index]['price'],
                    'location': widget.product[widget.index]['location'],
                    'isRented': true,
                  });



                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(docId)
                        .update({'balance': currentBalance - widget.product[widget.index]['price']
                    });
                    setState(() {});

                    Fluttertoast.showToast(msg: 'Successful Rent');
                  }else{

                    Fluttertoast.showToast(msg: 'no enough balance');
                  }

                }
              },
            ),
          ],
        ),

      ),
    );
  }
}
