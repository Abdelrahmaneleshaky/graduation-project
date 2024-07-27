import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'model/user_model.dart';


class Wallet extends StatefulWidget
{
  const Wallet({super.key, required this.email});
  final String email;

  @override
  State<Wallet> createState() => _Wallet();
}
class _Wallet extends State<Wallet>
{
  List<dynamic>  activities = [],profiles = [];

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  fetchusers() async
  {
    QuerySnapshot qn = await _firestore.collection('users').get();
    setState(()
    {
      for (int i = 0; i < qn.docs.length; i++)
      {
        profiles.add({
          "email": qn.docs[i]["email"],
          "firstName": qn.docs[i]["firstName"],
          "imageURL": qn.docs[i]["imageURL"],
          "secondName": qn.docs[i]["secondName"],
          "balance": qn.docs[i]["balance"],
          "uid": qn.docs[i]['uid'],
        });
      }
    });

    return qn.docs;
  }

  fetchActivities() async
  {
    QuerySnapshot qn = await _firestore.collection('Activities').get();
    setState(()
    {
      for (int i = 0; i < qn.docs.length; i++)
      {
        activities.add({
          'email': qn.docs[i]['email'],
          'imageUrl': qn.docs[i]['imageUrl'],
          'price': qn.docs[i]['price'],
          'location': qn.docs[i]['location'],
        });
      }
    });

    return qn.docs;
  }


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
    fetchusers();
    fetchActivities();

  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title:  Text('My Wallet',style:TextStyle(fontWeight: FontWeight.bold , color:Colors.white),),
        actions: <Widget>[
          CircleAvatar(backgroundImage:AssetImage("assets/img/logo.png") ,),

        ],
        backgroundColor: Colors.green,

      ),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(right: MediaQuery.sizeOf(context).width*0.55),

            child: Text("Welcome Mr.${loggedInUser.secondName}",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
          ),


          SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),

              SizedBox(
                height: 150,
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal:7),
                  child: Container(
                    width: 370,
                    decoration: BoxDecoration(
                      color:Colors.green,

                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 150,top: 10,left: 35),
                              child:  Text(
                                'Your Wallet',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                            ),
                            Icon(Icons.more_vert,
                              color: Colors.white,)
                          ],
                        ),
                        SizedBox(height:20,),
                        Padding(
                          padding: EdgeInsets.only(right: 230),
                          child:  Text(
                            'Balance',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                        SizedBox(height:10,),
                        Padding(
                          padding: EdgeInsets.only(right: 190),
                          child:  Text(
                            '${profiles.firstWhere((profile) => profile['email'] == widget.email, orElse: () => null)?['balance'] ?? '0'}',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),



                ),
              ),


          SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),

          const Text(" Activities",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),

          SizedBox(
            height:350.h,
            width:370,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: activities.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context,index)
              {
                return activities.isNotEmpty ? (activities[index]['email'] == widget.email ? Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: 380,
                    decoration:  const BoxDecoration(

                        color: Colors.grey

                    ),
                    child: Row(
                      children: [

                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(backgroundImage:AssetImage("assets/img/logo.png"),radius: 30.0,),
                            ),


                          ],
                        ),

                        Column(
                          children: [
                            Text(activities[index]['location'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                            const SizedBox(height:20, width:10,),
                            Row(
                              children: [
                                Text("${activities[index]['price']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                SizedBox(height:0, width:50,),

                              ],
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ) : const SizedBox.shrink()) : const SizedBox.shrink();
              },
            ),
          ),




        ],
      ),
    );
  }
}
