

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_text_button/cupertino_text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'model/product_model.dart';
import 'model/user_model.dart';

class updateproduct extends StatefulWidget {
   updateproduct({super.key,required this.imageURL,required this.Name,required this.bath,required this.bed,required this.description,required this.location,required this.price,required this.space,required this.token});
  final String imageURL;
   final String Name;
   final int bath;
   final int bed;
   final String description;
   final String location;
   final int price;
   final int space;
   final int token;


  @override
  State<updateproduct> createState() => _updateproductState();
}

class _updateproductState extends State<updateproduct> {

  int _savedbath =0;
  String _savedName = '';
  int _savedbed = 0;
  int _savedprice = 0;
  String _savedlocation = '';
  String _saveddescription = '';
  int _savedspace = 0;
  int _savedtoken = 0;
  String _savedimage='';
  bool _showNameField = false;
  bool _showbedField = false;
  bool _showpriceField = false;
  bool _showbathField = false;
  bool _showtokenField = false;
  bool _showspaceField = false;
  bool _showlocationField = false;
  bool _showdescriptionField = false;
  final NameEditingController = new TextEditingController();
  final bedEditingController = new TextEditingController();
  final priceEditingController = new TextEditingController();
  final bathEditingController = new TextEditingController();
  final tokenEditingController = new TextEditingController();
  final locationEditingController = new TextEditingController();
  final descriptionEditingController = new TextEditingController();
  final spaceEditingController = new TextEditingController();





 final products = FirebaseFirestore.instance;


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child:
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:130,left: 160),
                  child: Row(

                    children: [
                      Container(
                          width:60,
                          height: 60,

                          decoration:BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child:
                          Icon(CupertinoIcons.person,size: 50,color: Colors.white,)),
                    ],
                  ),
                ) ,

                Padding(
                  padding: const EdgeInsets.only(top:80,left: 0),
                  child: Row(
                    children: [
                      SizedBox(width: 20,),
                      Column(
                        children: [

                          Row(
                            children: [
                              Container(
                                  width: 250,
                                  height: 30,
                                  child: Text("Name:${widget.Name} ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                              SizedBox(width: 10,),
                              ElevatedButton(
                                onPressed: () =>
                                    setState(() =>
                                    _showNameField = !_showNameField),
                                child: Text(_showNameField ? 'Done' : 'Edit'),

                              ),


                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 150,
                                child: Visibility(

                                  visible: _showNameField,
                                  child: Row(


                                      children: [

                                        Expanded(

                                          child: TextField(
                                            controller:NameEditingController,
                                            decoration: InputDecoration(

                                                hintText: 'Enter text here'),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.check),
                                          onPressed: () async {
                                            QuerySnapshot querySnapshot = await FirebaseFirestore
                                                .instance
                                                .collection(
                                                'products') // Replace with your collection name
                                                .where('imageURL', isEqualTo: widget.imageURL)
                                                .get();

                                            DocumentSnapshot documentSnapshot = querySnapshot.docs
                                                .first;
                                            String docId = documentSnapshot.id;
                                            setState(() async{
                                              _savedName = NameEditingController.text;
                                              _showNameField = false; // Hide the text field after saving
                                              NameEditingController.clear();
                                              await FirebaseFirestore.instance
                                                  .collection('products')
                                                  .doc(docId)
                                                  .update(
                                                  {'Name': _savedName});
                                              setState(() {});

                                              Fluttertoast.showToast(msg: 'Successful edited'); // Clear the text field for next use
                                            });
                                            // Perform any additional actions with the saved text (optional)
                                            print('Saved text: $_savedName');
                                          },
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Container(
                                  width: 250,
                                  height: 30,
                                  child: Text("bath:${widget.bath}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                              SizedBox(width: 10,),
                              ElevatedButton(
                                onPressed: () =>
                                    setState(() =>
                                    _showbathField = !_showbathField),
                                child: Text(_showbathField ? 'Done' : 'Edit'),

                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 150,
                                child: Visibility(

                                  visible: _showbathField,
                                  child: Row(


                                      children: [

                                        Expanded(

                                          child: TextField(
                                            controller:bathEditingController,
                                            decoration: InputDecoration(

                                                hintText: 'Enter text here'),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.check),
                                          onPressed: () async {
                                            QuerySnapshot querySnapshot = await FirebaseFirestore
                                                .instance
                                                .collection(
                                                'products') // Replace with your collection name
                                                .where('imageURL', isEqualTo: widget.imageURL)
                                                .get();

                                            DocumentSnapshot documentSnapshot = querySnapshot.docs
                                                .first;
                                            String docId = documentSnapshot.id;
                                            setState(() async{
                                              int bathCount = int.parse(bathEditingController.text);
                                              _savedbath = bathCount;
                                              _showbathField = false; // Hide the text field after saving
                                              bathEditingController.clear();
                                              await FirebaseFirestore.instance
                                                  .collection('products')
                                                  .doc(docId)
                                                  .update(
                                                  {'bath': _savedbath});
                                              setState(() {});

                                              Fluttertoast.showToast(msg: 'Successful edited'); // Clear the text field for next use
                                            });
                                            // Perform any additional actions with the saved text (optional)
                                            print('Saved text: $_savedbath');
                                          },
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  width: 250,
                                  height: 30,
                                  child: Text("bed:${widget.bed}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                              SizedBox(width: 10,),
                              ElevatedButton(
                                onPressed: () =>
                                    setState(() =>
                                    _showbedField = !_showbedField),
                                child: Text(_showbedField ? 'Done' : 'Edit'),

                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 200,
                                child: Visibility(

                                  visible: _showbedField,
                                  child: Row(


                                      children: [

                                        Expanded(

                                          child: TextField(
                                            controller:bedEditingController,
                                            decoration: InputDecoration(

                                                hintText: 'Enter text here'),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.check),
                                          onPressed: () async {
                                            QuerySnapshot querySnapshot = await FirebaseFirestore
                                                .instance
                                                .collection(
                                                'products') // Replace with your collection name
                                                .where('bed', isEqualTo: widget.bed)
                                                .get();

                                            DocumentSnapshot documentSnapshot = querySnapshot.docs
                                                .first;
                                            String docId = documentSnapshot.id;
                                            setState(() async{
                                              int bedCount = int.parse(bedEditingController.text);
                                              _savedbed = bedCount;
                                              _showbedField = false; // Hide the text field after saving
                                              bedEditingController.clear();
                                              await FirebaseFirestore.instance
                                                  .collection('products')
                                                  .doc(docId)
                                                  .update(
                                                  {'bed': _savedbed});
                                              setState(() {});

                                              Fluttertoast.showToast(msg: 'Successful edited'); // Clear the text field for next use
                                            });
                                            // Perform any additional actions with the saved text (optional)
                                            print('Saved text: $_savedbed');
                                          },
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Container(height:80,
                                  width: 250,

                                  child: Text("price:${widget.price}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                              SizedBox(width: 10,),
                              ElevatedButton(
                                onPressed: () =>
                                    setState(() =>
                                    _showpriceField = !_showpriceField),
                                child: Text(_showpriceField ? 'Done' : 'Edit'),

                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 150,
                                child: Visibility(

                                  visible: _showpriceField,
                                  child: Row(


                                      children: [

                                        Expanded(

                                          child: TextField(
                                            controller:priceEditingController,
                                            decoration: InputDecoration(

                                                hintText: 'Enter text here'),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.check),
                                          onPressed: () async {
                                            QuerySnapshot querySnapshot = await FirebaseFirestore
                                                .instance
                                                .collection(
                                                'products') // Replace with your collection name
                                                .where('imageURL', isEqualTo: widget.imageURL)
                                                .get();

                                            DocumentSnapshot documentSnapshot = querySnapshot.docs
                                                .first;
                                            String docId = documentSnapshot.id;
                                            setState(() async{
                                              int priceCount = int.parse(priceEditingController.text);
                                              _savedprice = priceCount;
                                              _showpriceField = false; // Hide the text field after saving
                                              priceEditingController.clear();
                                              await FirebaseFirestore.instance
                                                  .collection('products')
                                                  .doc(docId)
                                                  .update(
                                                  {'price': _savedprice});
                                              setState(() {});

                                              Fluttertoast.showToast(msg: 'Successful edited'); // Clear the text field for next use
                                            });
                                            // Perform any additional actions with the saved text (optional)
                                            print('Saved text: $_savedprice');
                                          },
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(height:80,
                                  width: 250,

                                  child: Text("token:${widget.token}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                              SizedBox(width: 10,),
                              ElevatedButton(
                                onPressed: () =>
                                    setState(() =>
                                    _showtokenField = !_showtokenField),
                                child: Text(_showtokenField ? 'Done' : 'Edit'),

                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 150,
                                child: Visibility(

                                  visible: _showtokenField,
                                  child: Row(


                                      children: [

                                        Expanded(

                                          child: TextField(
                                            controller:tokenEditingController,
                                            decoration: InputDecoration(

                                                hintText: 'Enter text here'),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.check),
                                          onPressed: () async {
                                            QuerySnapshot querySnapshot = await FirebaseFirestore
                                                .instance
                                                .collection(
                                                'products') // Replace with your collection name
                                                .where('imageURL', isEqualTo: widget.imageURL)
                                                .get();

                                            DocumentSnapshot documentSnapshot = querySnapshot.docs
                                                .first;
                                            String docId = documentSnapshot.id;
                                            setState(() async{
                                              int priceCount = int.parse(tokenEditingController.text);
                                              _savedtoken = priceCount;
                                              _showtokenField = false; // Hide the text field after saving
                                              tokenEditingController.clear();
                                              await FirebaseFirestore.instance
                                                  .collection('products')
                                                  .doc(docId)
                                                  .update(
                                                  {'token': _savedtoken});
                                              setState(() {});

                                              Fluttertoast.showToast(msg: 'Successful edited'); // Clear the text field for next use
                                            });
                                            // Perform any additional actions with the saved text (optional)
                                            print('Saved text: $_savedtoken');
                                          },
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Container(height:80,
                                  width: 250,

                                  child: Text("space:${widget.space}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                              SizedBox(width: 10,),
                              ElevatedButton(
                                onPressed: () =>
                                    setState(() =>
                                    _showspaceField = !_showspaceField),
                                child: Text(_showspaceField ? 'Done' : 'Edit'),

                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 150,
                                child: Visibility(

                                  visible: _showspaceField,
                                  child: Row(


                                      children: [

                                        Expanded(

                                          child: TextField(
                                            controller:spaceEditingController,
                                            decoration: InputDecoration(

                                                hintText: 'Enter text here'),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.check),
                                          onPressed: () async {
                                            QuerySnapshot querySnapshot = await FirebaseFirestore
                                                .instance
                                                .collection(
                                                'products') // Replace with your collection name
                                                .where('imageURL', isEqualTo: widget.imageURL)
                                                .get();

                                            DocumentSnapshot documentSnapshot = querySnapshot.docs
                                                .first;
                                            String docId = documentSnapshot.id;
                                            setState(() async{
                                              int spaceCount = int.parse(spaceEditingController.text);
                                              _savedspace = spaceCount;
                                              _showspaceField = false; // Hide the text field after saving
                                              spaceEditingController.clear();
                                              await FirebaseFirestore.instance
                                                  .collection('products')
                                                  .doc(docId)
                                                  .update(
                                                  {'space': _savedspace});
                                              setState(() {});

                                              Fluttertoast.showToast(msg: 'Successful edited'); // Clear the text field for next use
                                            });
                                            // Perform any additional actions with the saved text (optional)
                                            print('Saved text: $_savedspace');
                                          },
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(height:80,
                                  width: 250,

                                  child: Text("location:${widget.location}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                              SizedBox(width: 10,),
                              ElevatedButton(
                                onPressed: () =>
                                    setState(() =>
                                    _showlocationField = !_showlocationField),
                                child: Text(_showlocationField ? 'Done' : 'Edit'),

                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 150,
                                child: Visibility(

                                  visible: _showlocationField,
                                  child: Row(


                                      children: [

                                        Expanded(

                                          child: TextField(
                                            controller:locationEditingController,
                                            decoration: InputDecoration(

                                                hintText: 'Enter text here'),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.check),
                                          onPressed: () async {
                                            QuerySnapshot querySnapshot = await FirebaseFirestore
                                                .instance
                                                .collection(
                                                'products') // Replace with your collection name
                                                .where('imageURL', isEqualTo: widget.imageURL)
                                                .get();

                                            DocumentSnapshot documentSnapshot = querySnapshot.docs
                                                .first;
                                            String docId = documentSnapshot.id;
                                            setState(() async{
                                              _savedlocation = locationEditingController.text;
                                              _showlocationField = false; // Hide the text field after saving
                                              locationEditingController.clear();
                                              await FirebaseFirestore.instance
                                                  .collection('products')
                                                  .doc(docId)
                                                  .update(
                                                  {'location': _savedlocation});
                                              setState(() {});

                                              Fluttertoast.showToast(msg: 'Successful edited'); // Clear the text field for next use
                                            });
                                            // Perform any additional actions with the saved text (optional)
                                            print('Saved text: $_savedlocation');
                                          },
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(height:80,
                                  width: 250,

                                  child: Text("description:${widget.description}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                              SizedBox(width: 10,),
                              ElevatedButton(
                                onPressed: () =>
                                    setState(() =>
                                    _showdescriptionField = !_showdescriptionField),
                                child: Text(_showdescriptionField ? 'Done' : 'Edit'),

                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 150,
                                child: Visibility(

                                  visible: _showdescriptionField,
                                  child: Row(


                                      children: [

                                        Expanded(

                                          child: TextField(
                                            controller:descriptionEditingController,
                                            decoration: InputDecoration(

                                                hintText: 'Enter text here'),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.check),
                                          onPressed: () async {
                                            QuerySnapshot querySnapshot = await FirebaseFirestore
                                                .instance
                                                .collection(
                                                'products') // Replace with your collection name
                                                .where('imageURL', isEqualTo: widget.imageURL)
                                                .get();

                                            DocumentSnapshot documentSnapshot = querySnapshot.docs
                                                .first;
                                            String docId = documentSnapshot.id;
                                            setState(() async{
                                              _saveddescription = descriptionEditingController.text;
                                              _showdescriptionField = false; // Hide the text field after saving
                                              descriptionEditingController.clear();
                                              await FirebaseFirestore.instance
                                                  .collection('products')
                                                  .doc(docId)
                                                  .update(
                                                  {'description': _saveddescription});
                                              setState(() {});

                                              Fluttertoast.showToast(msg: 'Successful edited'); // Clear the text field for next use
                                            });
                                            // Perform any additional actions with the saved text (optional)
                                            print('Saved text: $_saveddescription');
                                          },
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),







                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1),
                                  borderRadius: BorderRadius.circular(9)
                              ),
                              child: Row(
                                children: [
                                  Text("picture of the invest",style: TextStyle(fontSize: 18),),
                                  SizedBox(width: 50,),
                                  IconButton(onPressed: () async {
                                    ImagePicker imagePicker=ImagePicker();
                                    XFile? file= await imagePicker.pickImage(source: ImageSource.gallery);


                                    if (file == null) return;

                                    Reference referenceRoot = FirebaseStorage.instance.ref();
                                    Reference referenceDirImages =
                                    referenceRoot.child('product_Img');
                                    Reference referenceImageToUpload =
                                    referenceDirImages.child(widget.Name);

                                      //Store the file
                                      await referenceImageToUpload.putFile(File(file!.path));
                                      //Success: get the download URL
                                      _savedimage = await referenceImageToUpload.getDownloadURL();
                                      print('Image URL: $_savedimage');
                                      QuerySnapshot querySnapshot = await FirebaseFirestore
                                          .instance
                                          .collection(
                                          'products') // Replace with your collection name
                                          .where('imageURL', isEqualTo: widget.imageURL)
                                          .get();

                                      DocumentSnapshot documentSnapshot = querySnapshot.docs
                                          .first;
                                      String docId = documentSnapshot.id;
                                      setState(() async{
                                        await FirebaseFirestore.instance
                                            .collection('products')
                                            .doc(docId)
                                            .update(
                                            {'imageURL': _savedimage});
                                        setState(() {});

                                        Fluttertoast.showToast(msg: 'Successful edited'); // Clear the text field for next use
                                      });



                                  }
                                      ,icon:Icon(Icons.camera_alt,color: Colors.green,))
                                ],
                              ),
                            ),
                          ),




                        ],
                      ),
                    ],
                  ),
                ),



                SizedBox(height: 50,),



              ],
            )
        )

    );
  }
}
