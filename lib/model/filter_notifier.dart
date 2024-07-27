import 'package:flutter/cupertino.dart';

class FilterNotifier extends ChangeNotifier
{
  String location = '';
  bool chosen = false;
  int range = 0, beds = 0, baths = 0;
  int chosenIndex = -1, chosenIndexBed = -1, chosenIndexBath = -1;

  filterLocation({required String chosenLocation})
  {
    location = chosenLocation;
    notifyListeners();
  }

  filterPriceFrom({required int fromRange})
  {
    range = fromRange;
    notifyListeners();
  }
}