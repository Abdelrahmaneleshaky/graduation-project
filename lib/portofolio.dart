


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_text_button/cupertino_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Portofolio extends StatefulWidget
{
  const Portofolio({super.key, required this.email,required this.status});
  final String email;
  final String status;

  @override
  State<Portofolio> createState() => _Portofolio();
}
class _Portofolio extends State<Portofolio>
{
  List<dynamic> investments = [], rents = [];


  List<String> images= [
    "assets/img/1.png",
    "assets/img/2.png",
  ];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  fetchProducts() async
  {
    QuerySnapshot qn = await _firestore.collection('investments').get();
    setState(()
    {
      for (int i = 0; i < qn.docs.length; i++)
      {
        investments.add({
          "email": qn.docs[i]["email"],
          "imageUrl": qn.docs[i]["imageUrl"],
          "location": qn.docs[i]["location"],
          "price": qn.docs[i]["price"],
          "tokens": qn.docs[i]["tokens"],
        });
      }


    });

    return qn.docs;
  }






  fetchRents() async
  {
    QuerySnapshot qn = await _firestore.collection('rents').get();
    setState(()
    {
      for (int i = 0; i < qn.docs.length; i++)
      {
        rents.add({
          "email": qn.docs[i]["email"],
          "imageUrl": qn.docs[i]["imageUrl"],
          "location": qn.docs[i]["location"],
          "price": qn.docs[i]["price"],
          "isRented": qn.docs[i]["isRented"],
        });
      }
    });

    return qn.docs;
  }


  @override
  void initState()
  {
    super.initState();
    fetchProducts();
    fetchRents();

  }
  


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Portofolio',style:TextStyle(fontWeight: FontWeight.bold , color:Colors.white),),
        actions: <Widget>[
          IconButton(

            icon:  Icon(
              CupertinoIcons.search,
              color: Colors.white,
            ),

            onPressed: () {
              // do something
            },
          ),
          IconButton(

            icon:  Icon(
              CupertinoIcons.heart_fill,
              color: Colors.white,
            ),

            onPressed: () {
              // do something
            },
          ),
          IconButton(

            icon:  Icon(
              Icons.more_vert,
              color: Colors.white,
            ),

            onPressed: () {
              // do something
            },
          )
        ],
        backgroundColor: Colors.green,

      ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),

              Padding(
                padding:  EdgeInsets.only(right: MediaQuery.sizeOf(context).width*0.27),

                child: Text("My Tokens for invest",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              ),


              SizedBox(
                height:200,
                width:double.infinity,
                child: ListView.builder(
                  itemCount: investments.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return widget.email == investments[index]['email'] ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal:25),
                      child: Container(
                        decoration: BoxDecoration(

                            border: Border.all(color: Colors.black,width: 2.5)

                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Image.network(
                              investments[index]['imageUrl'],
                              height: 100.h,
                            ),
                            Text('${investments[index]['price']} EGP'),
                            Text('Location: ${investments[index]['location']}'),
                            Text('Tokens: ${investments[index]['tokens'].toString()}'),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0,left: 90),
                              child: Container(
                                width: 75,
                                height: 19,

                                decoration:BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50),),

                                child: Center(
                                  child: CupertinoTextButton( text: 'Sell token',
                                    style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 12,),
                                    onTap: () async {
                                      final firestore = FirebaseFirestore.instance;

                                      // Use the collection method on the instance
                                      final activitiesCollection = firestore.collection('Activities');
                                      QuerySnapshot querySnapshot = await FirebaseFirestore
                                          .instance
                                          .collection(
                                          'users') // Replace with your collection name
                                          .where('email', isEqualTo: widget.email)
                                          .get();
                                      QuerySnapshot querySnapshot2 = await FirebaseFirestore
                                          .instance
                                          .collection(
                                          'products') // Replace with your collection name
                                          .where('imageURL',
                                          isEqualTo: investments[index]['imageUrl'])
                                          .get();
                                      QuerySnapshot querySnapshot3 = await FirebaseFirestore
                                          .instance
                                          .collection(
                                          'investments') // Replace with your collection name
                                          .where('imageUrl',
                                          isEqualTo: investments[index]['imageUrl'] )
                                          .where('tokens', isEqualTo: investments[index]['tokens'])
                                          .get();

                                      DocumentSnapshot documentSnapshot = querySnapshot
                                          .docs
                                          .first;
                                      DocumentSnapshot documentSnapshot2 = querySnapshot2
                                          .docs
                                          .first;
                                      DocumentSnapshot documentSnapshot3 = querySnapshot3
                                          .docs
                                          .first;
                                      String docId = documentSnapshot.id;
                                      String docId2 = documentSnapshot2.id;
                                      String docId3 = documentSnapshot3.id;

                                      int currentBalance = documentSnapshot['balance'];
                                      int tokens = documentSnapshot2['token'];


                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(docId)
                                          .update(
                                          {
                                            'balance': currentBalance +
                                                investments[index]['price']
                                          });
                                      setState(() {});
                                      await FirebaseFirestore.instance
                                          .collection('products')
                                          .doc(docId2)
                                          .update(
                                          {
                                            'token': tokens +
                                                investments[index]['tokens']
                                          });


                                      setState(() {});
                                      await activitiesCollection.add(
                                          {
                                            'email': widget.email,
                                            'imageUrl': investments[index]['imageUrl'],
                                            'price': '+${investments[index]['price']} EGP',
                                            'location': investments[index]['location'],
                                          });



                                      deleteDocument('investments', docId3);






                                      Fluttertoast.showToast(msg: 'Successful sold');
                                    } // Do your text stuff here.
                                    ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ) : const SizedBox.shrink();
                  },
                ),
              ),


              SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),

              Padding(
                padding:  EdgeInsets.only(right: MediaQuery.sizeOf(context).width*0.60),

                child: Text("My rent",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              ),


              SizedBox(
                height:200,
                width:double.infinity,
                child: ListView.builder(
                  itemCount: rents.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return widget.email == rents[index]['email'] ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal:25),
                      child: Container(
                        decoration: BoxDecoration(

                            border: Border.all(color: Colors.black,width: 2.5)

                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Image.network(
                              rents[index]['imageUrl'],
                              height: 100.h,
                            ),
                            Text('${rents[index]['price']} EGP'),
                            Text('Location: ${rents[index]['location']}'),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0,left: 90),
                              child: Container(
                                width: 75,
                                height: 19,

                                decoration:BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(50),),

                                child: Center(
                                  child: CupertinoTextButton( text: 'cancel renting',
                                      style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 12,),
                                      onTap: () async {

                                        QuerySnapshot querySnapshot = await FirebaseFirestore
                                            .instance
                                            .collection(
                                            'rents') // Replace with your collection name
                                            .where('imageUrl',
                                            isEqualTo: rents[index]['imageUrl'])
                                            .get();

                                        DocumentSnapshot documentSnapshot = querySnapshot
                                            .docs
                                            .first;

                                        String docId = documentSnapshot.id;

                                        deleteDocument('rents', docId);


                                        Fluttertoast.showToast(msg: 'Successful canceled');
                                      } // Do your text stuff here.
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ) : const SizedBox.shrink();
                  },
                ),
              )


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
