import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mp2/models/rolldicemodel.dart';

class RollDice extends StatelessWidget{
  final VoidCallback? onPressed;
  final RollDiceModel rollDiceModel;

  const RollDice({this.onPressed,required this.rollDiceModel,super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: rollDiceModel,builder: (BuildContext context, Widget? child) {
      return ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all((rollDiceModel.remainingrolls!=0)?Colors.blue:Colors.grey)),
      onPressed: disableAndEnable,
      child: Text(printMessage()),
      );
    });
    
  }

  void disableAndEnable(){
    if(rollDiceModel.remainingrolls!=0) {
      onPressed!();
    }
  }

  String printMessage(){
    int remianing = rollDiceModel.remainingrolls;
    if(remianing != 0) {
      return 'Roll ($remianing)';
    }
    return 'Out of Rolls';
  }

}