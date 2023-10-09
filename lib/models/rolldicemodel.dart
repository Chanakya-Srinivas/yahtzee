import 'package:flutter/material.dart';

class RollDiceModel extends ChangeNotifier{
  int remainingrolls;

  RollDiceModel({required this.remainingrolls});

  void rollNonHeldDice(VoidCallback roll){
    roll();
    remainingrolls--;
    notifyListeners();
  }

  void resetRemainingRolls(){
    remainingrolls = 3;
    notifyListeners();
  }

}