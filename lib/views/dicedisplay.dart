import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DiceDisplay extends StatelessWidget{

  final int? value;
  final VoidCallback? dieClick;
  final bool isHeld;

  const DiceDisplay({this.value, this.dieClick,required this.isHeld, super.key});

  @override
  Widget build(BuildContext context) {
    bool flag = isHeld;
    return Container(
      //padding: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: 100,
      height: 100,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: (!flag || value == 0)? Colors.black : Colors.red,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text((value!=0) ? '$value' : '' , style: TextStyle(fontSize: 45),),
        ],
      ),
    );
    
  }

}