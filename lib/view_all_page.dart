import 'dart:developer';
import 'package:akarna/constants.dart';
import 'package:akarna/details_page.dart';
import 'package:akarna/model/filter_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_text_button/cupertino_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'filter_widget.dart';

class Viewall extends StatefulWidget {
  const Viewall({super.key, required this.email,required this.status});
  final String email;
  final String status;

  @override
  State<Viewall> createState() => _ViewallState();
}

class _ViewallState extends State<Viewall> {
  List<String> images = [
    "assets/img/1.png",
    "assets/img/2.png",
  ];
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "Name": qn.docs[i]["Name"],
          "price": qn.docs[i]["price"],
          "space": qn.docs[i]["space"],
          "imageURL": qn.docs[i]["imageURL"],
          "bath": qn.docs[i]["bath"],
          "bed": qn.docs[i]["bed"],
          "description": qn.docs[i]["description"],
          "location": qn.docs[i]["location"],
          "token": qn.docs[i]["token"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    log("Length = ${_products.length}");

    return ChangeNotifierProvider(
      create: (context) => FilterNotifier(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
              children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: SizedBox(
                    width: 320,
                    height: 50,
                    child: SearchField(
                      suggestions: [],
                      searchInputDecoration: const InputDecoration(
                          label: Text("What are you looking for?"),
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2))),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Consumer<FilterNotifier>(
                    builder: (BuildContext context, FilterNotifier value, Widget? child) => FilterWidget(onChanged: (data) => setState(()
                    {
                      value.chosen = true;
                      value.location = allLocations[data!];
                    })),
                  ),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),

            Consumer<FilterNotifier>(
              builder: (BuildContext context, FilterNotifier value, Widget? child) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_products.length, (index) => GestureDetector(
                    onTap: () => setState(()
                    {
                      value.range = _products[index]['price'];
                      value.chosenIndex = index;
                    }),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Container(
                        height: 25.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2.5),
                          borderRadius: BorderRadius.circular(15),
                            color: value.chosenIndex == index ? Colors.green : Colors.white,
                        ),
                        child: Center(child: Text(_products[index]['price'].toString(), style: TextStyle(color: value.chosenIndex == index ? Colors.white : Colors.black))),
                      ),
                    ),
                  )),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Consumer<FilterNotifier>(
              builder: (BuildContext context, value, Widget? child) => Column(
                children: List.generate(_products.length, (index) => value.chosen ? (value.location == _products[index]['location'] && value.range >= _products[index]['price'] ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Container(
                    height: 220,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(14)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 130,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(
                              _products[index]["imageURL"],
                              fit: BoxFit.fitWidth,
                              height: 120,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${_products[index]["price"]} Egp"),
                              Text("${_products[index]["space"]} m^2"),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(CupertinoIcons.location_solid),
                            Text("${_products[index]["location"]} "),
                            Padding(
                              padding: const EdgeInsets.only(left: 90),
                              child: CupertinoTextButton(
                                text: "View details",
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsPage(products: _products, index: index, email: widget.email,status: widget.status,)));
                                },
                              ),
                            ),

                            SizedBox(width: MediaQuery.sizeOf(context).width * 0.05),
                          ],
                        ),
                      ],
                    ),
                  ),
                ) : const SizedBox.shrink()) : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Container(
                    height: 220.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(14)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 130,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                              child: Image.network(
                                _products[index]["imageURL"],
                                fit: BoxFit.fitWidth,
                                height: 120,
                                width: MediaQuery.of(context).size.width,
                              )),
                        ),

                        SizedBox(height: MediaQuery.sizeOf(context).height * 0.001),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${_products[index]["price"]} Egp"),
                              Text("${_products[index]["space"]} m^2"),
                            ],
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(CupertinoIcons.location_solid),
                            Text("${_products[index]["location"]} "),

                            Padding(
                              padding: const EdgeInsets.only(left: 90),
                              child: CupertinoTextButton(
                                text: _products[index]['token'] == 0 ? 'Sold' : "View details",
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                onTap: () {
                                  if(_products[index]['token'] != 0)
                                    {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsPage(products: _products, index: index, email: widget.email,status:widget.status,)));
                                    }

                                  else
                                  {
                                    Fluttertoast.showToast(msg: 'All tokens are sold');

                                  }
                                },
                              ),
                            ),

                            SizedBox(width: MediaQuery.sizeOf(context).width * 0.05),
                          ],
                        ),

                        SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                      ],
                    ),
                  ),
                )),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}