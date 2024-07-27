import 'package:akarna/model/token_notifier.dart';
import 'package:akarna/request_to_be_investor.dart';
import 'package:akarna/stream_token.dart';
import 'package:akarna/update_tokens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget
{
  const DetailsPage({super.key, required this.products, required this.index, required this.email,required this.status,});
  final List<dynamic> products;
  final String email;
  final String status;
  final int index;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
{
  List<String> images= [
    "assets/img/1.png",
    "assets/img/2.png",
  ];
  int num =0;
  int _value = 1;
  double min = 1.0;
  double max = 1.0;
  Stream<int>? _tokenStream;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState()
  {
    super.initState();
    _tokenStream = _firestore.collection('products').doc(docId).snapshots().map((snapshot) => snapshot.data()?['token'] as int);
    _value = widget.products[widget.index]['token'];
    max = double.parse(widget.products[widget.index]['token'].toString());
  }

  @override
  Widget build(BuildContext context)
  {
    return ChangeNotifierProvider(
      create: (context) => TokenNotifier(),
      child: Consumer<TokenNotifier>(
        builder: (BuildContext context, TokenNotifier value, Widget? child) => Scaffold(
          body:
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),
                Padding(
                  padding: const EdgeInsets.only(right: 330),
                  child: IconButton(  onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back),color: Colors.black,),
                ),

                Image.network(
                  widget.products[widget.index]["imageURL"],fit: BoxFit.contain,
                  height: 280,
                  width: MediaQuery.of(context).size.width,
                ),

                SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [

                      Icon(CupertinoIcons.star_fill,color: Colors.green,),
                      Icon(CupertinoIcons.star_fill,color: Colors.green,),
                      Icon(CupertinoIcons.star_fill,color: Colors.green,),
                      Icon(CupertinoIcons.star_fill,color: Colors.green,),
                      Icon(CupertinoIcons.star_lefthalf_fill,color: Colors.green,),
                      SizedBox(width: MediaQuery.sizeOf(context).width*0.3,),
                      Text(value.price > 0 ? value.price.toDouble().toString() : widget.products[widget.index]['price'].toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    ],

                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(widget.products[widget.index]['Name'],style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(width: MediaQuery.sizeOf(context).width*0.20,),
                      const Icon(CupertinoIcons.location_solid,color: Colors.green,),
                      Column(
                        children: [
                          Text( widget.products[widget.index]['location']),
                        ],
                      )
                    ],


                  ),

                ),

                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),

                Row(
                  children: [
                    SizedBox(width: MediaQuery.sizeOf(context).width * 0.05),

                    const Text("Tokens:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),

                    SizedBox(width: MediaQuery.sizeOf(context).width * 0.025),

                    StreamBuilder<int>(
                        stream: _tokenStream,
                        builder: (context, snapshot) => Text('${snapshot.data.toString()} available',style: TextStyle(color: Colors.green,fontSize: 25,fontWeight: FontWeight.bold),)
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 20),
                  child: Row(
                    children: [


                      Container(
                        height: 40,
                        width:  40,
                        decoration: BoxDecoration(
                            color: Colors.green ,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: IconButton(
                            color: Colors.white,
                            onPressed:(){
                              setState((){
                                if(_value < max){
                                  /// Add as many as you want
                                  _value++;
                                  value.changePriceByToken(tokens: _value, currentPrice: widget.products[widget.index]['price']);

                                }
                              });
                            }, icon: const Icon(Icons.add)),
                      ),
                      SizedBox(width: 5,),
                      Text(_value.toString(),style: TextStyle(color: Colors.green,fontSize: 25,fontWeight: FontWeight.bold),),
                      SizedBox(width: 5,),
                      Container(
                        height: 40,
                        width:  40,
                        decoration: BoxDecoration(
                            color: Colors.green ,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: IconButton(
                            color: Colors.white,
                            onPressed:(){
                              setState((){
                                if(_value > min){
                                  /// Subtract as many as you want
                                  _value--;
                                  value.changePriceByToken(tokens: _value, currentPrice: widget.products[widget.index]['price']);

                                }

                              });
                            }, icon: const Icon(Icons.remove)),
                      ),


                      Slider(
                        value: _value.toDouble(),
                        min: min,
                        max: max,
                        activeColor: Colors.green,
                        inactiveColor: Colors.orange,
                        label: 'Set volume value',
                        onChanged: (double newValue) {
                          setState(() {
                            _value = newValue.round();
                            value.changePriceByToken(tokens: _value, currentPrice: widget.products[widget.index]['price']);
                          });
                        },

                      ),

                    ],

                  ),
                ),
                SizedBox(height: 10,),
                Padding(

                  padding: const EdgeInsets.only(top: 10.0,left: 22),
                  child: Row(
                    children: [
                      Text("Description" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 22),
                  child: Row(
                    children: [
                      Container(
                          width:250,
                          height:100 ,
                          child: Text( widget.products[widget.index]['description'])),
                    ],
                  ),
                ),

                const SizedBox(height:30),

                StreamBuilder<int>(
                  stream: _tokenStream,
                  builder: (context, snapshot)
                  {
                    return widget.status == 'Investor' ?FloatingActionButton.extended(
                      backgroundColor: Colors.green,
                      label: const Text("Invest",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
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
                        String docId = documentSnapshot.id;

                        int currentBalance = documentSnapshot['balance'];

                        if(snapshot.data! > 0 && snapshot.data! >= _value ) {
                          if(currentBalance >= value.price){
                          await updateTokens(imageUrl: widget.products[widget
                              .index]['imageURL'],
                              chosenTokens: value.chosenTokens,
                              products: widget.products,
                              index: widget.index);
                          FirebaseFirestore firebaseFirestore = FirebaseFirestore
                              .instance;
                          await firebaseFirestore.collection('investments').add(
                              {
                                'email': widget.email,
                                'tokens': value.chosenTokens,
                                'imageUrl': widget.products[widget
                                    .index]['imageURL'],
                                'price': value.price,
                                'location': widget.products[widget
                                    .index]['location'],
                              });
                          await firebaseFirestore.collection('Activities').add(
                              {
                                'email': widget.email,
                                'imageUrl': widget.products[widget
                                    .index]['imageURL'],
                                'price': '-${value.price} EGP',
                                'location': widget.products[widget
                                    .index]['location'],
                              });

                          await FirebaseFirestore.instance
                                .collection('users')
                                .doc(docId)
                                .update(
                                {'balance': currentBalance - value.price});
                            setState(() {});

                            Fluttertoast.showToast(msg: 'Successful Payment');}
                          else{
                            Fluttertoast.showToast(msg: 'No enough balance');
                          }

                        }

                        else
                        {
                          Fluttertoast.showToast(msg: 'No enough tokens');

                        }
                      },

                    ):FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  label: const Text("Invest",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                  onPressed: () async
                  {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>RequestInvest(email: widget.email)));

                  } );
                  }
                ),

              ],
            ),

          ),
        ),
      ),
    );
  }
}


