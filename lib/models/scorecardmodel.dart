import 'package:flutter/material.dart';

class ScoreCardModel extends ChangeNotifier{
  int total;

  ScoreCardModel({required this.total});

  void updateTotal(int total1){
    total = total1;
    print(total);
    notifyListeners();
  }

}