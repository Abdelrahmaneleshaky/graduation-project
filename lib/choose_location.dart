

import 'package:akarna/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseLocation extends StatelessWidget
{
  const ChooseLocation({super.key, this.onChanged,});
  final void Function(int?)? onChanged;

  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width*0.6,
      child: DropdownButtonFormField(
        dropdownColor: Colors.white,
        style: const TextStyle(color:Colors.grey, fontWeight: FontWeight.bold),
        validator: (data)
        {
          if(data == null)
          {
            return 'choose a location';
          }
          return null;
        },
        hint: const Text('choose a location', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
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
            prefixIcon: const Icon(Icons.place_rounded, color: Colors.black)
        ),
        icon: const Icon(CupertinoIcons.chevron_down_circle, color: Colors.black),
        padding: const EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(16),
        isExpanded: false,
        items: [
          DropdownMenuItem<int>(value: 0, alignment: AlignmentDirectional.center, child: Text('cairo', style: Styles.styleOfDropDown)),
          DropdownMenuItem<int>(value: 1, alignment: AlignmentDirectional.center, child: Text('alexandria', style: Styles.styleOfDropDown)),
          DropdownMenuItem<int>(value: 2, alignment: AlignmentDirectional.center, child: Text('tanta', style: Styles.styleOfDropDown)),
          DropdownMenuItem<int>(value: 3, alignment: AlignmentDirectional.center, child: Text('banha', style: Styles.styleOfDropDown)),
          DropdownMenuItem<int>(value: 4, alignment: AlignmentDirectional.center, child: Text('kafr elshikh', style: Styles.styleOfDropDown)),
          DropdownMenuItem<int>(value: 5, alignment: AlignmentDirectional.center, child: Text('sharm el shikh', style: Styles.styleOfDropDown)),
          DropdownMenuItem<int>(value: 6, alignment: AlignmentDirectional.center, child: Text('marssa matrouh', style: Styles.styleOfDropDown)),
          DropdownMenuItem<int>(value: 7, alignment: AlignmentDirectional.center, child: Text('marsa alam', style: Styles.styleOfDropDown)),
          DropdownMenuItem<int>(value: 8, alignment: AlignmentDirectional.center, child: Text('port saiid', style: Styles.styleOfDropDown)),
          DropdownMenuItem<int>(value: 9, alignment: AlignmentDirectional.center, child: Text('el so5na', style: Styles.styleOfDropDown)),
          DropdownMenuItem<int>(value: 10, alignment: AlignmentDirectional.center, child: Text('luxor', style: Styles.styleOfDropDown)),
          DropdownMenuItem<int>(value: 11, alignment: AlignmentDirectional.center, child: Text('aswan', style: Styles.styleOfDropDown)),
          DropdownMenuItem<int>(value: 12, alignment: AlignmentDirectional.center, child: Text('asiut', style: Styles.styleOfDropDown)),
          DropdownMenuItem<int>(value: 13, alignment: AlignmentDirectional.center, child: Text('el asmailia', style: Styles.styleOfDropDown)),
        ],
        onChanged: onChanged,
      ),
    );
  }
}