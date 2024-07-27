import 'package:akarna/LoginScreen.dart';
import 'package:akarna/personalInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/user_model.dart';

class account_page extends StatefulWidget {
  const account_page({super.key});

  @override
  State<account_page> createState() => _account_pageState();
}

class _account_pageState extends State<account_page> {

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
      body: SingleChildScrollView(
        child:
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:130,left: 30),
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
                  SizedBox(width: 20,),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text("MR.${loggedInUser.secondName}",style: TextStyle(color: Colors.green,fontSize: 40,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Row(
                        children: [
                          Text("${loggedInUser.firstName} ",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Row(
                        children: [
                          Text("${loggedInUser.secondName}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
                        ],
                      )


                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60.0,top: 50),
              child: Row(
                children: [
                  Text("Status",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                  SizedBox(width: 50,),
                  Text("${loggedInUser.status}",style: TextStyle(color:Colors.green,fontWeight: FontWeight.bold,fontSize: 30),),
                ],
              ),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Row(
                children: [
                  Icon(Icons.info_outline,color: Colors.green,),
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>personalInfo()));

                    },
                    child: Text("Personnal information",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold),),
                  )


                ],
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Row(
                children: [
                  Icon(Icons.logout,color: Colors.green,),
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: (){
                      logout(context);

                    },
                    child: Text("Logout",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold),),
                  )


                ],
              ),
            )

          ],
        )
      )

    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

}
