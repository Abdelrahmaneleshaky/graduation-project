import 'package:akarna/add_invest.dart';
import 'package:akarna/add_rent.dart';
import 'package:akarna/updateRent.dart';
import 'package:akarna/updateproduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_text_button/cupertino_text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'LoginScreen.dart';

class adminpage extends StatefulWidget {
  const adminpage({super.key,required this.email});
  final String email;

  @override
  State<adminpage> createState() => _adminpageState();
}

class _adminpageState extends State<adminpage> {

  List<dynamic> products = [],rents=[],invest_requests=[];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  fetchProducts() async
  {
    QuerySnapshot qn = await _firestore.collection('products').get();
    setState(()
    {
      for (int i = 0; i < qn.docs.length; i++)
      {
        products.add({
          "Name": qn.docs[i]["Name"],
          "imageURL": qn.docs[i]["imageURL"],
          "location": qn.docs[i]["location"],
          "bed": qn.docs[i]["bed"],
          "bath": qn.docs[i]["bath"],
          "description": qn.docs[i]["description"],
          "price": qn.docs[i]["price"],
          "space": qn.docs[i]["space"],
          "token": qn.docs[i]["token"],

        });
      }


    });

    return qn.docs;
  }

  var _firestoreInstance2 = FirebaseFirestore.instance;
  fetchProducts2() async{
    QuerySnapshot qn =
    await _firestoreInstance2.collection("products_rent").get();
    setState(() {
      for (int i =0;i<qn.docs.length;i++){
        rents.add(
            {
              "Name": qn.docs[i]["Name"],
              "price": qn.docs[i]["price"],
              "space": qn.docs[i]["space"],
              "imageURL": qn.docs[i]["imageURL"],
              "bath": qn.docs[i]["bath"],
              "bed": qn.docs[i]["bed"],
              "description": qn.docs[i]["description"],
              "location": qn.docs[i]["location"],
            }


        );

      }
    });

    return qn.docs;



  }
  var _firestoreInstance3 = FirebaseFirestore.instance;
  fetchinvestRequest() async{
    QuerySnapshot qn =
    await _firestoreInstance3.collection("invest_request").get();
    setState(() {
      for (int i =0;i<qn.docs.length;i++){
        invest_requests.add(
            {
              "email": qn.docs[i]["email"],
              "Name": qn.docs[i]["Name"],

            }


        );

      }
    });

    return qn.docs;



  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
  @override
  void initState()
  {
    super.initState();
    fetchProducts();
    fetchProducts2();
    fetchinvestRequest();

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admins',style:TextStyle(fontWeight: FontWeight.bold , color:Colors.white),),

        backgroundColor: Colors.green,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => adminpage(email: widget.email)));
                

              },
              child: Icon(Icons.refresh)
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>AddInvest()));


              },
              child: Text("add invest",style: TextStyle(color:Colors.white,fontSize:15,fontWeight:FontWeight.bold),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>AddRent()));


              },
              child: Text("add rent",style: TextStyle(color:Colors.white,fontSize:15,fontWeight:FontWeight.bold),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: (){
                logout(context);

              },
              child: Text("Logout",style: TextStyle(color:Colors.white,fontSize:15,fontWeight:FontWeight.bold),),
            ),
          ),
        ]

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),

            Padding(
              padding:  EdgeInsets.only(right: MediaQuery.sizeOf(context).width*0.60),

              child: Text("invests",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            ),


            SizedBox(
              height:230,
              width:double.infinity,
              child: ListView.builder(
                itemCount: products.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:25),
                    child: Container(
                      decoration: BoxDecoration(

                          border: Border.all(color: Colors.black,width: 2.5)

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Image.network(
                            products[index]['imageURL'],
                            height: 100.h,
                          ),
                          Text('${products[index]['price'].toString()} EGP'),
                          Text('Location: ${products[index]['location']}'),
                          Text('Tokens: ${products[index]['token'].toString()}'),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0,left: 90),
                            child: Container(
                              width: 75,
                              height: 19,

                              decoration:BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50),),

                              child: Center(
                                child: CupertinoTextButton( text: 'update',
                                    style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 12,),
                                    onTap: () async {

                                          Navigator.push(context,MaterialPageRoute(builder: (context)=>updateproduct(imageURL: products[index]['imageURL'],Name:'${products[index]['Name']}',bath:products[index]['bath'],bed:products[index]['bed'],price:products[index]['price'],space:products[index]['space'],token:products[index]['token'],description:'${products[index]['description']}',location:'${products[index]['location']}')));





                                    } // Do your text stuff here.
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0,left: 90),
                            child: Container(
                              width: 75,
                              height: 19,

                              decoration:BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(50),),
                            child: Container(
                              child: Center(
                                child: CupertinoTextButton(text: 'delete',
                                  style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 12,),
                                  onTap: ()  async{
                                    QuerySnapshot querySnapshot = await FirebaseFirestore
                                        .instance
                                        .collection(
                                        'products') // Replace with your collection name
                                        .where('imageURL', isEqualTo: products[index]['imageURL'])
                                        .get();


                                    DocumentSnapshot documentSnapshot = querySnapshot
                                        .docs
                                        .first;

                                    String docId = documentSnapshot.id;


                                    deleteDocument('products', docId);

                                    Fluttertoast.showToast(msg: 'Successful deleted');

                                  }),
                              ),
                            ),
                          )
                          )
                        ],
                      ),
                    ),
                  ) ;
                },
              ),
            ),


            SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),

            Padding(
              padding:  EdgeInsets.only(right: MediaQuery.sizeOf(context).width*0.60),

              child: Text("Rents",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            ),


            SizedBox(
              height:230,
              width:double.infinity,
              child: ListView.builder(
                itemCount: rents.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:25),
                    child: Container(
                      decoration: BoxDecoration(

                          border: Border.all(color: Colors.black,width: 2.5)

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Image.network(
                            rents[index]['imageURL'],
                            height: 100.h,
                          ),
                          Text('${rents[index]['price'].toString()} EGP'),
                          Text('Location: ${rents[index]['location']}'),
                          Text('space: ${rents[index]['space'].toString()}  m^2'),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0,left: 90),
                            child: Container(
                              width: 75,
                              height: 19,

                              decoration:BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50),),

                              child: Center(
                                child: CupertinoTextButton( text: 'update',
                                    style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 12,),
                                    onTap: () async {

                                      Navigator.push(context,MaterialPageRoute(builder: (context)=>updateRent(imageURL: rents[index]['imageURL'],Name:'${rents[index]['Name']}',bath:rents[index]['bath'],bed:rents[index]['bed'],price:rents[index]['price'],space:rents[index]['space'],description:'${rents[index]['description']}',location:'${rents[index]['location']}')));





                                    } // Do your text stuff here.
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 10.0,left: 90),
                              child: Container(
                                width: 75,
                                height: 19,

                                decoration:BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(50),),
                                child: Container(
                                  child: Center(
                                    child: CupertinoTextButton(text: 'delete',
                                        style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 12,),
                                        onTap: ()  async{
                                          QuerySnapshot querySnapshot = await FirebaseFirestore
                                              .instance
                                              .collection(
                                              'products_rent') // Replace with your collection name
                                              .where('imageURL', isEqualTo: rents[index]['imageURL'])
                                              .get();


                                          DocumentSnapshot documentSnapshot = querySnapshot
                                              .docs
                                              .first;

                                          String docId = documentSnapshot.id;


                                          deleteDocument('products_rent', docId);

                                          Fluttertoast.showToast(msg: 'Successful deleted');

                                        }),
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ) ;
                },
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(right: MediaQuery.sizeOf(context).width*0.60),

              child: Text("invest requests",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            ),


            SizedBox(
              height:230,
              width:double.infinity,
              child: ListView.builder(
                itemCount: invest_requests.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:25),
                    child: Container(
                      decoration: BoxDecoration(

                          border: Border.all(color: Colors.black,width: 2.5)

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Text('email:${invest_requests[index]['email']} '),
                          Text('Location: ${invest_requests[index]['Name']}'),
                          Text('want to be investor'),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0,left: 90),
                            child: Container(
                              width: 75,
                              height: 19,

                              decoration:BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50),),

                              child: Center(
                                child: CupertinoTextButton( text: 'Accept',
                                    style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 12,),
                                    onTap: () async {
                                      QuerySnapshot querySnapshot = await FirebaseFirestore
                                          .instance
                                          .collection(
                                          'users') // Replace with your collection name
                                          .where('email', isEqualTo: invest_requests[index]['email'])
                                          .get();


                                      DocumentSnapshot documentSnapshot = querySnapshot
                                          .docs
                                          .first;

                                      String docId = documentSnapshot.id;
                                        setState(() async{
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(docId)
                                            .update(
                                        {'status':"Investor"});
                                        setState(() {});

                                        Fluttertoast.showToast(msg: 'Successful accepted');
                                        QuerySnapshot querySnapshot2 = await FirebaseFirestore
                                            .instance
                                            .collection(
                                            'invest_request') // Replace with your collection name
                                            .where('email', isEqualTo: invest_requests[index]['email'])
                                            .get();


                                        DocumentSnapshot documentSnapshot2 = querySnapshot2
                                            .docs
                                            .first;

                                        String docId2 = documentSnapshot2.id;


                                        deleteDocument('invest_request', docId2);
                                        // Clear the text field for next use
                                        });


                                    } // Do your text stuff here.
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 10.0,left: 90),
                              child: Container(
                                width: 75,
                                height: 19,

                                decoration:BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(50),),
                                child: Container(
                                  child: Center(
                                    child: CupertinoTextButton(text: 'Reject',
                                        style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 12,),
                                        onTap: ()  async{
                                          QuerySnapshot querySnapshot = await FirebaseFirestore
                                              .instance
                                              .collection(
                                              'invest_request') // Replace with your collection name
                                              .where('email', isEqualTo: invest_requests[index]['email'])
                                              .get();


                                          DocumentSnapshot documentSnapshot = querySnapshot
                                              .docs
                                              .first;

                                          String docId = documentSnapshot.id;


                                          deleteDocument('invest_request', docId);

                                          Fluttertoast.showToast(msg: 'Successful rejected');

                                        }),
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ) ;
                },
              ),
            ),




          ],
        ),
      ),
    );
  }
  Future<void> deleteDocument(String collectionName, String documentId) async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection(collectionName).doc(documentId);

    try {
      await docRef.delete();

      print("Document deleted successfully!");
    } catch (error) {
      print("Error deleting document: $error");
    }
  }
}
