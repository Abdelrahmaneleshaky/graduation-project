import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_text_button/cupertino_text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'model/user_model.dart';

class personalInfo extends StatefulWidget {
  const personalInfo({super.key});


  @override
  State<personalInfo> createState() => _personalInfoState();
}

class _personalInfoState extends State<personalInfo> {

  String _savedID = '';
  String _savedfirst = '';
  String _savedphone = '';
  String _savedsecond = '';
  String _savedcredit = '';
  bool _showfirstnameField = false;
  bool _showsecondnameField = false;
  bool _showphoneField = false;
  bool _showIDField = false;
  bool _showcreditField = false;
  final firstnameEditingController = new TextEditingController();
  final secondnameEditingController = new TextEditingController();
  final phoneEditingController = new TextEditingController();
  final IDEditingController = new TextEditingController();
  final creditEditingController = new TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
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
                                        child: Text("First Name:${loggedInUser.firstName} ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                        onPressed: () =>
                                            setState(() =>
                                            _showfirstnameField = !_showfirstnameField),
                                        child: Text(_showfirstnameField ? 'Done' : 'Edit'),

                                      ),


                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 150,
                                      child: Visibility(

                                        visible: _showfirstnameField,
                                        child: Row(


                                            children: [

                                              Expanded(

                                                child: TextField(
                                                  controller:firstnameEditingController,
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
                                                      'users') // Replace with your collection name
                                                      .where('email', isEqualTo: loggedInUser.email)
                                                      .get();

                                                  DocumentSnapshot documentSnapshot = querySnapshot.docs
                                                      .first;
                                                  String docId = documentSnapshot.id;
                                                  setState(() async{
                                                    _savedfirst = firstnameEditingController.text;
                                                    _showfirstnameField = false; // Hide the text field after saving
                                                    firstnameEditingController.clear();
                                                     await FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(docId)
                                                        .update(
                                                        {'firstName': _savedfirst});
                                                    setState(() {});

                                                    Fluttertoast.showToast(msg: 'Successful edited'); // Clear the text field for next use
                                                  });
                                                  // Perform any additional actions with the saved text (optional)
                                                  print('Saved text: $_savedfirst');
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
                                        child: Text("Second Name:${loggedInUser.secondName}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                      onPressed: () =>
                                          setState(() =>
                                          _showsecondnameField = !_showsecondnameField),
                                      child: Text(_showsecondnameField ? 'Done' : 'Edit'),

                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 150,
                                      child: Visibility(

                                        visible: _showsecondnameField,
                                        child: Row(


                                            children: [

                                              Expanded(

                                                child: TextField(
                                                  controller:secondnameEditingController,
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
                                                      'users') // Replace with your collection name
                                                      .where('email', isEqualTo: loggedInUser.email)
                                                      .get();

                                                  DocumentSnapshot documentSnapshot = querySnapshot.docs
                                                      .first;
                                                  String docId = documentSnapshot.id;
                                                  setState(() async{
                                                    _savedsecond = secondnameEditingController.text;
                                                    _showsecondnameField = false; // Hide the text field after saving
                                                    secondnameEditingController.clear();
                                                    await FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(docId)
                                                        .update(
                                                        {'secondName': _savedsecond});
                                                    setState(() {});

                                                    Fluttertoast.showToast(msg: 'Successful edited'); // Clear the text field for next use
                                                  });
                                                  // Perform any additional actions with the saved text (optional)
                                                  print('Saved text: $_savedsecond');
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
                                        child: Text("Phone:${loggedInUser.phone}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                      onPressed: () =>
                                          setState(() =>
                                          _showphoneField = !_showphoneField),
                                      child: Text(_showphoneField ? 'Done' : 'Edit'),

                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 200,
                                      child: Visibility(

                                        visible: _showphoneField,
                                        child: Row(


                                            children: [

                                              Expanded(

                                                child: TextField(
                                                  controller:phoneEditingController,
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
                                                      'users') // Replace with your collection name
                                                      .where('email', isEqualTo: loggedInUser.email)
                                                      .get();

                                                  DocumentSnapshot documentSnapshot = querySnapshot.docs
                                                      .first;
                                                  String docId = documentSnapshot.id;
                                                  setState(() async{
                                                    _savedphone = phoneEditingController.text;
                                                    _showphoneField = false; // Hide the text field after saving
                                                    phoneEditingController.clear();
                                                    await FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(docId)
                                                        .update(
                                                        {'phone': _savedphone});
                                                    setState(() {});

                                                    Fluttertoast.showToast(msg: 'Successful edited'); // Clear the text field for next use
                                                  });
                                                  // Perform any additional actions with the saved text (optional)
                                                  print('Saved text: $_savedphone');
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

                                        child: Text("ID number:${loggedInUser.IDnum}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                      onPressed: () =>
                                          setState(() =>
                                          _showIDField = !_showIDField),
                                      child: Text(_showIDField ? 'Done' : 'Edit'),

                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 150,
                                      child: Visibility(

                                        visible: _showIDField,
                                        child: Row(


                                            children: [

                                              Expanded(

                                                child: TextField(
                                                  controller:IDEditingController,
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
                                                      'users') // Replace with your collection name
                                                      .where('email', isEqualTo: loggedInUser.email)
                                                      .get();

                                                  DocumentSnapshot documentSnapshot = querySnapshot.docs
                                                      .first;
                                                  String docId = documentSnapshot.id;
                                                  setState(() async{
                                                    _savedID = IDEditingController.text;
                                                    _showIDField = false; // Hide the text field after saving
                                                    IDEditingController.clear();
                                                    await FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(docId)
                                                        .update(
                                                        {'Idnum': _savedID});
                                                    setState(() {});

                                                    Fluttertoast.showToast(msg: 'Successful edited'); // Clear the text field for next use
                                                  });
                                                  // Perform any additional actions with the saved text (optional)
                                                  print('Saved text: $_savedID');
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
                                        height: 60,
                                        child: Text("credit card:${loggedInUser.creditcard}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                      onPressed: () =>
                                          setState(() =>
                                          _showcreditField = !_showcreditField),
                                      child: Text(_showcreditField ? 'Done' : 'Edit'),

                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 200,
                                      child: Visibility(

                                        visible: _showcreditField,
                                        child: Row(


                                            children: [

                                              Expanded(

                                                child: TextField(
                                                  controller:creditEditingController,
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
                                                      'users') // Replace with your collection name
                                                      .where('email', isEqualTo: loggedInUser.email)
                                                      .get();

                                                  DocumentSnapshot documentSnapshot = querySnapshot.docs
                                                      .first;
                                                  String docId = documentSnapshot.id;
                                                  setState(() async{
                                                    _savedcredit = creditEditingController.text;
                                                    _showcreditField = false; // Hide the text field after saving
                                                    creditEditingController.clear();
                                                    await FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(docId)
                                                        .update(
                                                        {'creditcard': _savedcredit});
                                                    setState(() {});

                                                    Fluttertoast.showToast(msg: 'Successful edited'); // Clear the text field for next use
                                                  });
                                                  // Perform any additional actions with the saved text (optional)
                                                  print('Saved text: $_savedcredit');
                                                },
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ],
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
