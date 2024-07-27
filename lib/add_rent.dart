import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'model/rent_model.dart';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';




class AddRent extends StatefulWidget {
  const AddRent({super.key});

  @override
  State<AddRent> createState() => _AddRentState();
}

class _AddRentState extends State<AddRent> {

  final _formKey = GlobalKey<FormState>();

  final NameEditingController = new TextEditingController();
  final bedEditingController = new TextEditingController();
  final priceEditingController = new TextEditingController();
  final bathEditingController = new TextEditingController();
  final locationEditingController = new TextEditingController();
  final descriptionEditingController = new TextEditingController();
  final spaceEditingController = new TextEditingController();


  String imageUrl = '';

  @override
  Widget build(BuildContext context) {

    final NameField = TextFormField(
      autofocus: false,
      controller: NameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Name cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid name(Min. 3 Character)");
        }
        return null;
      },

      onSaved: (value)
      {
        NameEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    final descriptionField = TextFormField(
      autofocus: false,
      controller: descriptionEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("description cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid description(Min. 3 Character)");
        }
        return null;
      },

      onSaved: (value)
      {
        descriptionEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "description",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );


    final locationField = TextFormField(
      autofocus: false,
      controller: locationEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("location cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid location(Min. 3 Character)");
        }
        return null;
      },

      onSaved: (value)
      {
        locationEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "location",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final bedField = TextFormField(
      autofocus: false,
      controller: bedEditingController,
      keyboardType: TextInputType.number,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{1,}$');
        if (value!.isEmpty) {
          return ("bed cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid bed(Min.1 Character)");
        }
        return null;
      },

      onSaved: (value)
      {
        bedEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "bed",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    final bathField = TextFormField(
      autofocus: false,
      controller: bathEditingController,
      keyboardType: TextInputType.number,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{1,}$');
        if (value!.isEmpty) {
          return ("bath cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid bath(Min.1 Character)");
        }
        return null;
      },

      onSaved: (value)
      {
        bathEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "bath",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    final priceField = TextFormField(
      autofocus: false,
      controller: priceEditingController,
      keyboardType: TextInputType.number,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{1,}$');
        if (value!.isEmpty) {
          return ("price cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid price(Min.1 Character)");
        }
        return null;
      },

      onSaved: (value)
      {
        priceEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "price",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    final spaceField = TextFormField(
      autofocus: false,
      controller: spaceEditingController,
      keyboardType: TextInputType.number,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{1,}$');
        if (value!.isEmpty) {
          return ("space cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid space(Min.1 Character)");
        }
        return null;
      },

      onSaved: (value)
      {
        spaceEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "space",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final AddButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          postDetailsToFirestore();
        },
        child: Text("Add", textAlign: TextAlign.center,
          style: TextStyle(fontSize:20 ,
              color: Colors.white,fontWeight: FontWeight.bold),),
      ),

    );


    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.green,)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,

            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height:200 ,
                      child: Image.asset("assets/img/logo.png",
                        fit: BoxFit.contain,),
                    ),
                    SizedBox(height: 25,),
                    NameField,
                    SizedBox(height: 25,),
                    descriptionField,
                    SizedBox(height: 25,),
                    locationField,
                    SizedBox(height: 25,),
                    priceField,
                    SizedBox(height: 25,),
                    bathField,
                    SizedBox(height: 25,),
                    bedField,
                    SizedBox(height: 25,),
                    spaceField,
                    SizedBox(height: 25,),
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
                            Text("upload rent picture",style: TextStyle(fontSize: 18),),
                            SizedBox(width: 50,),
                            IconButton(onPressed: () async {
                              ImagePicker imagePicker=ImagePicker();
                              XFile? file= await imagePicker.pickImage(source: ImageSource.gallery);


                              if (file == null) return;

                              Reference referenceRoot = FirebaseStorage.instance.ref();
                              Reference referenceDirImages =
                              referenceRoot.child('product_Img');
                              Reference referenceImageToUpload =
                              referenceDirImages.child(NameEditingController.text);

                              try {
                                //Store the file
                                await referenceImageToUpload.putFile(File(file!.path));
                                //Success: get the download URL
                                imageUrl = await referenceImageToUpload.getDownloadURL();
                                print('Image URL: $imageUrl');
                              } catch (error) {
                                //Some error occurred
                              }

                            }
                                ,icon:Icon(Icons.camera_alt,color: Colors.green,))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 25,),
                    AddButton,
                    SizedBox(height: 45,),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


    RentModel rentModel =  RentModel();

    // writing all the values
    rentModel.Name =NameEditingController.text;
    rentModel.space = int.parse(spaceEditingController.text);
    rentModel.bath =int.parse(bathEditingController.text);
    rentModel.imageURL = imageUrl;
    rentModel.bed=int.parse(bedEditingController.text);
    rentModel.description=descriptionEditingController.text;
    rentModel.location=locationEditingController.text;
    rentModel.price =int.parse(priceEditingController.text);

    await firebaseFirestore
        .collection("products_rent")
        .add(rentModel.toMap());
    Fluttertoast.showToast(msg: "Added successfully :) ");

    Navigator.pop(context);
  }
}
