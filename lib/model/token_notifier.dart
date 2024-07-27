import 'package:flutter/widgets.dart';

class TokenNotifier extends ChangeNotifier
{
  int price = 0;
  int chosenTokens = 0;

  changePriceByToken({required int tokens, required int currentPrice})
  {
    chosenTokens = tokens;
    price = ((currentPrice / 20) * tokens).toInt();
    notifyListeners();
  }
}