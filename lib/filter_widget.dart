
import 'package:akarna/constants.dart';
import 'package:akarna/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterWidget extends StatelessWidget
{
  const FilterWidget({super.key, this.onChanged,});
  final void Function(int?)? onChanged;

  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
      width: 320.w,
      height: 60,
      child: DropdownButtonFormField(
        dropdownColor: Colors.white,
        style: const TextStyle(color:Colors.grey, fontWeight: FontWeight.bold),
        validator: (data)
        {
          if(data == null)
          {
            return 'Filter';
          }
          return null;
        },
        hint: const Text('Filter', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
        decoration: InputDecoration(
            errorStyle: Styles.errorStyle,
            enabledBorder: Styles.textFormFieldOutlineInputBorder(),
            errorBorder: Styles.textFormFieldOutlineInputBorder(),
            focusedErrorBorder: Styles.textFormFieldOutlineInputBorder(),
            focusedBorder: Styles.textFormFieldOutlineInputBorder(),
            border: Styles.textFormFieldOutlineInputBorder(),
            disabledBorder: Styles.textFormFieldOutlineInputBorder(),
            fillColor:Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.list, color: Colors.black)
        ),

        borderRadius: BorderRadius.circular(16),
        isExpanded: false,
        items: List.generate(allLocations.length, (index) => DropdownMenuItem<int>(value: index, alignment: AlignmentDirectional.center, child: Text(allLocations[index], style: Styles.styleOfDropDown))),
        onChanged: onChanged,
      ),
    );
  }
}