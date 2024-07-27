import 'package:akarna/constants.dart';
import 'package:akarna/details_page_rent.dart';
import 'package:akarna/model/filter_notifier.dart';
import 'package:akarna/price_filter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_text_button/cupertino_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'details_page.dart';
import 'filter_widget.dart';

class Viewall2 extends StatefulWidget
{
  const Viewall2({super.key, required this.email,required this.status});
  final String email;
  final String status;
  @override
  State<Viewall2> createState() => _Viewall2State();
}

class _Viewall2State extends State<Viewall2>
{
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  fetchProducts() async
  {
    QuerySnapshot qn =
        await _firestoreInstance.collection("products_rent").get();
    setState(()
    {
      for (int i = 0; i < qn.docs.length; i++)
      {
        _products.add({
          "Name": qn.docs[i]["Name"],
          "price": qn.docs[i]["price"],
          "space": qn.docs[i]["space"],
          "imageURL": qn.docs[i]["imageURL"],
          "bath": qn.docs[i]["bath"],
          "bed": qn.docs[i]["bed"],
          "description": qn.docs[i]["description"],
          "location": qn.docs[i]["location"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState()
  {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return ChangeNotifierProvider(
      create: (context) => FilterNotifier(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(children: [
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

            const SizedBox(height: 20),

            Consumer<FilterNotifier>(
              builder: (BuildContext context, value, Widget? child) => Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: FilterWidget(onChanged: (data) => setState(()
                {
                  value.chosen = true;
                  value.location = allLocations[data!];
                })),
              ),
            ),

            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),

            PriceFilter(products: _products),

            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),

            Consumer<FilterNotifier>(
              builder: (BuildContext context, FilterNotifier value, Widget? child) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.bed_double_fill, color: Colors.black),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_products.length, (index) => GestureDetector(
                        onTap: () => setState(()
                        {
                          value.beds = _products[index]['bed'];
                          value.chosenIndexBed = index;
                        }),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Container(
                            height: 25.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 2.5),
                              borderRadius: BorderRadius.circular(15),
                              color: value.chosenIndexBed == index ? Colors.green : Colors.white,
                            ),
                            child: Center(child: Text(_products[index]['bed'].toString(), style: TextStyle(color: value.chosenIndexBed == index ? Colors.white : Colors.black))),
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),

            Consumer<FilterNotifier>(
              builder: (BuildContext context, FilterNotifier value, Widget? child) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Icon(Icons.bathtub_rounded, color: Colors.black),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_products.length, (index) => GestureDetector(
                        onTap: () => setState(()
                        {
                          value.baths = _products[index]['bath'];
                          value.chosenIndexBath = index;
                        }),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Container(
                            height: 25.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 2.5),
                              borderRadius: BorderRadius.circular(15),
                              color: value.chosenIndexBath == index ? Colors.green : Colors.white,
                            ),
                            child: Center(child: Text(_products[index]['bath'].toString(), style: TextStyle(color: value.chosenIndexBath == index ? Colors.white : Colors.black))),
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Consumer<FilterNotifier>(
              builder: (BuildContext context, value, Widget? child) => Column(
                children: List.generate(_products.length, (index) => value.chosen ? (value.location == _products[index]['location'] && value.range >= _products[index]['price'] && value.beds >= _products[index]['bed'] && value.baths >= _products[index]['bath'] ? Padding(
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("${_products[index]["price"]} Egp"),

                                  SizedBox(width: MediaQuery.sizeOf(context).width * 0.05),

                                  const Icon(CupertinoIcons.bed_double_fill, color: Colors.black),
                                  Text(' ${_products[index]['bed']} bed'),

                                  SizedBox(width: MediaQuery.sizeOf(context).width * 0.05),

                                  const Icon(Icons.bathtub_rounded, color: Colors.black),
                                  Text(' ${_products[index]['bath']} bath'),
                                ],
                              ),
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
                                              DetailsPageRent(product: _products, index: index, email: widget.email,status: widget.status,)));
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
                    height: 225.h,
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
                              Row(
                                children: [
                                  Text("${_products[index]["price"]} Egp"),

                                  SizedBox(width: MediaQuery.sizeOf(context).width * 0.05),

                                  const Icon(CupertinoIcons.bed_double_fill, color: Colors.black),
                                  Text(' ${_products[index]['bed']} bed'),

                                  SizedBox(width: MediaQuery.sizeOf(context).width * 0.05),

                                  const Icon(Icons.bathtub_rounded, color: Colors.black),
                                  Text(' ${_products[index]['bath']} bath'),
                                ],
                              ),
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
                                              DetailsPageRent(product: _products, index: index, email: widget.email,status: widget.status,)));
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

            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
          ]),
        ),
      ),
    );
  }
}
