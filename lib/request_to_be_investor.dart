import 'package:akarna/model/token_notifier.dart';
import 'package:akarna/stream_token.dart';
import 'package:akarna/update_tokens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class RequestInvest extends StatefulWidget {
  const RequestInvest({super.key,required this.email});
  final String email;

  @override
  State<RequestInvest> createState() => _RequestInvestState();
}

class _RequestInvestState extends State<RequestInvest> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text('Request to be Investor',style:TextStyle(fontWeight: FontWeight.bold , color:Colors.white),),

          backgroundColor: Colors.green,


      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 85.0,top: 20),
                  child: Center(child: Text("Terms and Conditions",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                ),

              ],
            ),
            SizedBox(height: 0.1,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0,top: 10),
                  child: Container(
                      width:300,
                      height:600,
                      child: Text("1 - Users must be at least 18 years old to invest.\n2 - Tokens can be bought or sold through the App based on availability and demand.\n3  - The App may charge fees for transactions involving the purchase and sale of tokens. These fees will be disclosed to Users prior to completing any transaction.\n4 -  Users are responsible for any taxes or other charges that may apply to their transactions.\n5 - Investing in real estate through the purchase of tokens involves risk, including the risk of loss of capital. Users should carefully consider their investment objectives and risk tolerance before investing.\n6 - The value of tokens may fluctuate based on market conditions and the performance of the underlying Property.\n7 - The App and its operators are not responsible for any loss or damage arising from the use of the App or the purchase or sale of tokens.")),
                )
              ],
            ),
            FloatingActionButton.extended(
            backgroundColor: Colors.green,
            label: const Text("Send Request",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
            onPressed: () async
            {
              QuerySnapshot querySnapshot = await FirebaseFirestore
                  .instance
                  .collection(
                  'users') // Replace with your collection name
                  .where('email', isEqualTo: widget.email)
                  .get();

              DocumentSnapshot documentSnapshot = querySnapshot.docs
                  .first;


              String Name = documentSnapshot['firstName'];


              FirebaseFirestore firebaseFirestore = FirebaseFirestore
                  .instance;
              await firebaseFirestore.collection('invest_request').add(
                  {
                    'email': widget.email,
                    'Name': Name,

                  });


              setState(() {});

              Fluttertoast.showToast(msg: 'request sent');
              Navigator.pop(context);
            }

            )



          ],
        ),
      ),
    );
  }
}
