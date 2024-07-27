import 'package:akarna/choose_location.dart';
import 'package:akarna/stream_token.dart';
import 'package:akarna/view_all_page.dart';
import 'package:akarna/view_all_page2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_text_button/cupertino_text_button.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:searchfield/searchfield.dart';
import 'package:akarna/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'details_page_rent.dart';


class Homepage extends StatefulWidget {
const Homepage({super.key, required this.email,required this.status});
final String email;
final String status;

@override
State<Homepage> createState() => _Homepage();
}
class _Homepage extends State<Homepage> {
//invest products
List _products=[];
var _firestoreInstance = FirebaseFirestore.instance;
fetchProducts() async{
 QuerySnapshot qn =
 await _firestoreInstance.collection("products").get();
setState(() {
  for (int i =0;i<qn.docs.length;i++){
    _products.add(
      {
        "Name": qn.docs[i]["Name"],
        "price": qn.docs[i]["price"],
        "space": qn.docs[i]["space"],
        "imageURL": qn.docs[i]["imageURL"],
        "bath": qn.docs[i]["bath"],
        "bed": qn.docs[i]["bed"],
        "description": qn.docs[i]["description"],
        "location": qn.docs[i]["location"],
        "token": qn.docs[i]["token"],
      }


    );

  }
});

 return qn.docs;



}
// rent products

  List _products_rent=[];
  var _firestoreInstance2 = FirebaseFirestore.instance;
  fetchProducts2() async{
    QuerySnapshot qn =
    await _firestoreInstance2.collection("products_rent").get();
    setState(() {
      for (int i =0;i<qn.docs.length;i++){
        _products_rent.add(
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

@override
void initState() {
  fetchProducts();
  fetchProducts2();
  super.initState();
}
@override
Widget build(BuildContext context) {



return Scaffold(

appBar: AppBar(
  leading: const CircleAvatar(backgroundImage:AssetImage("assets/img/logo.png") ,),

  title: const Text('Akarna',style:TextStyle(fontWeight: FontWeight.bold),),




),
body:SingleChildScrollView(
  child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ChooseLocation(onChanged:(data){},),
          SizedBox(width: MediaQuery.sizeOf(context).width*0.25,),
          Icon(CupertinoIcons.bell_fill,color:Colors.green,),
        ],
      ),

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SearchField(suggestions:[],
          searchInputDecoration: InputDecoration(
              label: Text("Search"),
              prefixIcon: Icon(Icons.search,),
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2))
          ),


        ),
      ),

      SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),

      Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text("properities for invest",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
          ),
          const SizedBox(height:0, width:40,),
          CupertinoTextButton(
            text: 'View all',
            style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 20,),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Viewall(email: widget.email,status: widget.status,)));

              // Do your text stuff here.
            },
          ),
        ],
      ),


      SizedBox(
        height:200,
        width:double.infinity,
        child: ListView.builder(
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal:25),
              child: Container(
                decoration: BoxDecoration(

                    border: Border.all(color: Colors.black,width: 1),
                    borderRadius: BorderRadius.circular(14)

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.network(
                          _products[index]["imageURL"],fit: BoxFit.contain,
                          height: 120,
                          width: 200,
                        )),

                    Text("${_products[index]["price"]} Egp"),
                    Text("${_products[index]["space"]} m^2"),
                    CupertinoTextButton(
                      text: 'details    ${_products[index]['token'] == 0 ? 'sold' : ''}',
                      style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 20,),
                      onTap: () async
                      {
                        await streamTokens(imageUrl: _products[index]['imageURL']);

                        _products[index]['token'] == 0 ? Fluttertoast.showToast(msg: 'All tokens are sold') : Navigator.push(context,MaterialPageRoute(builder: (context)
                        {
                          return DetailsPage(products: _products, index: index, email: widget.email,status: widget.status,);
                        }));


                        // Do your text stuff here.
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: _products.length,
          scrollDirection: Axis.horizontal,
        ),
      ),


      SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),

      Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text("properities for rent",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
          ),
          const SizedBox(height:0, width:63,),
          CupertinoTextButton(
            text: 'View all',
            style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 20,),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Viewall2(email: widget.email,status: widget.status,)));
              // Do your text stuff here.
            },
          ),
        ],
      ),


      SizedBox(
        height:200,
        width:double.infinity,
        child: ListView.builder(
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal:25),
              child: Container(
                decoration: BoxDecoration(

                    border: Border.all(color: Colors.black,width: 1),
                    borderRadius: BorderRadius.circular(14)

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.network(
                          _products_rent[index]["imageURL"],fit: BoxFit.contain,
                          height: 120,
                          width: 200,
                        )),

                    Text("${_products_rent[index]["price"]} Egp"),
                    Text("${_products_rent[index]["space"]} m^2"),
                    CupertinoTextButton(
                      text: 'details',
                      style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 20,),
                      onTap: ()
                      {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=> DetailsPageRent(email: widget.email, product: _products_rent, index: index,status: widget.status,)));


                        // Do your text stuff here.
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: _products_rent.length,
          scrollDirection: Axis.horizontal,
        ),
      )


    ],
  ),
),
);
}
}