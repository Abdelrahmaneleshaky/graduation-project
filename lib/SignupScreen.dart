import 'dart:io';

import 'package:akarna/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'model/user_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  final _formKey = GlobalKey<FormState>();

  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  final phoneEditingController=new TextEditingController();
  final IDnumEditingController = new TextEditingController();
  final creditcardEditingController = new TextEditingController();

  CollectionReference _reference = FirebaseFirestore.instance.collection('users');

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {


    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid name(Min. 3 Character)");
        }
        return null;
      },

      onSaved: (value)
      {
        firstNameEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Second Name cannot be Empty");
        }
        return null;
      },

      onSaved: (value)
      {
        secondNameEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Second Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );


    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
            .hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },

      onSaved: (value)
      {
        emailEditingController.text=value!;
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
      controller: passwordEditingController,
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


      onSaved: (value)
      {
        passwordEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return "Password don't match";
        }
        return null;
      },


      onSaved: (value)
      {
        confirmPasswordEditingController.text=value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final phoneField= TextFormField(
      autofocus: false,
      controller: phoneEditingController,
      obscureText: false,
      validator: (value) {
        if (value!.isEmpty) {
          return ("phone cannot be Empty");
        }
        return null;
      },


      onSaved: (value)
      {
        phoneEditingController.text=value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "phone",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final IDnumField= TextFormField(
      autofocus: false,
      controller: IDnumEditingController,
      obscureText: false,
      validator: (value) {
        if (value!.isEmpty) {
          return ("IDnum cannot be Empty");
        }
        return null;
      },


      onSaved: (value)
      {
        IDnumEditingController.text=value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.add_card),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "National ID Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final creditcardField = TextFormField(
      autofocus: false,
      controller: creditcardEditingController,
      validator: (value) {
        if (value!.isEmpty) {
          return ("credit card cannot be Empty");
        }
        return null;
      },

      onSaved: (value)
      {
        creditcardEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.add_card_outlined),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "credit card number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final SignUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: Text("SignUp", textAlign: TextAlign.center,
          style: TextStyle(fontSize:20 ,
              color: Colors.white,fontWeight: FontWeight.bold),),
      ),

    );

    return Scaffold(
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
                    firstNameField,
                    SizedBox(height: 25,),
                    secondNameField,
                    SizedBox(height: 25,),
                    phoneField,
                    SizedBox(height: 25,),
                    IDnumField,
                    SizedBox(height: 25,),
                    creditcardField,
                    SizedBox(height: 25,),
                    emailField,
                    SizedBox(height: 25,),
                    passwordField,
                    SizedBox(height: 25,),
                    confirmPasswordField,
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
                            Text("please upload your ID",style: TextStyle(fontSize: 18),),
                            SizedBox(width: 50,),
                            IconButton(onPressed: () async {
                              ImagePicker imagePicker=ImagePicker();
                              XFile? file= await imagePicker.pickImage(source: ImageSource.camera);


                              if (file == null) return;

                              Reference referenceRoot = FirebaseStorage.instance.ref();
                              Reference referenceDirImages =
                              referenceRoot.child('users_ID');
                              Reference referenceImageToUpload =
                              referenceDirImages.child(firstNameEditingController.text);

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
                    SignUpButton,
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
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          case "imageUrl.isEmpty":
            errorMessage = "Please upload an image";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;
    userModel.phone = phoneEditingController.text;
    userModel.IDnum =IDnumEditingController.text;
    userModel.imageURL = imageUrl;
    userModel.creditcard=creditcardEditingController.text;
    userModel.status='Renter';
    userModel.admin=false;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => MyHomePage(title: "akarna", email: user.email!,status: 'Renter',)),
            (route) => false);
  }


}
