import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'model/filter_notifier.dart';

class PriceFilter extends StatefulWidget
{
  const PriceFilter({super.key, required this.products});
  final List<dynamic> products;

  @override
  State<PriceFilter> createState() => _PriceFilterState();
}

class _PriceFilterState extends State<PriceFilter>
{
  @override
  Widget build(BuildContext context)
  {
    return Consumer<FilterNotifier>(
      builder: (BuildContext context, FilterNotifier value, Widget? child) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const Icon(Icons.price_check, color: Colors.black),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.products.length, (index) => GestureDetector(
                onTap: () => setState(()
                {
                  value.range = widget.products[index]['price'];
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
                    child: Center(child: Text(widget.products[index]['price'].toString(), style: TextStyle(color: value.chosenIndex == index ? Colors.white : Colors.black))),
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
