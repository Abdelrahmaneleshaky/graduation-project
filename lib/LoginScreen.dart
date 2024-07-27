import 'package:akarna/SignupScreen.dart';
import 'package:akarna/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'adminpage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();


  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  //firebase

  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("please Enter your Email");
        }

        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("please Enter a valid Email");
        };
        return null;
      },

      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );


    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },


      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );


    final LoginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery
            .of(context)
            .size
            .width,
        onPressed: () async{
          if (await logincondition(emailController.text)){
            logInadmin(emailController.text, passwordController.text);
          }else{
          logIn(emailController.text, passwordController.text);
        }},
        child: Text("Login", textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,
              color: Colors.white, fontWeight: FontWeight.bold),),
      ),

    );

    return Scaffold(
      backgroundColor: Colors.white,
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
                      height: 200,
                      child: Image.asset("assets/img/logo.png",
                        fit: BoxFit.contain,),
                    ),
                    SizedBox(height: 45,),
                    emailField,
                    SizedBox(height: 25,),
                    passwordField,
                    SizedBox(height: 25,),
                    LoginButton,
                    SizedBox(height: 45,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account?"),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => SignupScreen()));
                          },
                          child: Text("SignUp", style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                              fontSize: 15),),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void logIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      QuerySnapshot querySnapshot = await FirebaseFirestore
          .instance
          .collection(
          'users') // Replace with your collection name
          .where('email', isEqualTo: email)
          .get();

      DocumentSnapshot documentSnapshot = querySnapshot
          .docs
          .first;

      String status = documentSnapshot['status'];

      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) =>
      {
        Fluttertoast.showToast(msg: "Login Successful"),
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => MyHomePage(title: "akarna", email: email,status: status,))),
      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      }


      );
    }
  }

  void logInadmin(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) =>
      {
        Fluttertoast.showToast(msg: "Login Successful"),
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => adminpage(email:email))),
      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      }


      );
    }
  }
  Future<bool> logincondition(String email) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore
        .instance
        .collection(
        'users') // Replace with your collection name
        .where('email', isEqualTo: email)
        .get();



    DocumentSnapshot documentSnapshot = querySnapshot
        .docs
        .first;

    bool admin= documentSnapshot['admin'];


   return admin;




    }



}

