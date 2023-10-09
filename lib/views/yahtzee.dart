import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mp2/models/dice.dart';
import 'package:mp2/models/rolldicemodel.dart';
import 'package:mp2/models/scorecard.dart';
import 'package:mp2/models/scorecardmodel.dart';
import 'package:mp2/views/dicedisplay.dart';
import 'package:mp2/views/rolldice.dart';
import 'package:mp2/views/scorecarddisplay.dart';

class Yahtzee extends StatefulWidget {
  const Yahtzee({super.key});
  
  @override
  State<StatefulWidget> createState() => _YahtzeeScreen();
}

class _YahtzeeScreen extends State<Yahtzee> {
  final Dice _dice = Dice(5);
  final ScoreCard _scoreCard = ScoreCard();
  final RollDiceModel rollDiceModel = RollDiceModel(remainingrolls: 3);
  List<bool> color =  List<bool>.filled(5, false);

  @override
  Widget build(BuildContext context) {
    final ScoreCardModel scoreCardModel = ScoreCardModel(total: _scoreCard.total);
    return Column(
      children: [
        const SizedBox(height : 20),
        ListenableBuilder(
          listenable: rollDiceModel, 
          builder: (BuildContext context, Widget? child){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(max(_dice.values.length, 5), (i){
                return InkWell(
                  onTap: () {
                    setState(() {
                      if(_dice.values.length==5){
                        _dice.toggleHold(i);
                        color[i] = _dice.isHeld(i);
                      }
                    });
                  },
                  child: DiceDisplay(value: _dice.values.length==5 ? _dice.values[i] : 0,
                    isHeld: color[i],
                    ),
                );
                
              }),
            );
          }
        ),
        RollDice(onPressed: () => rollDiceModel.rollNonHeldDice(() {_dice.roll();}), rollDiceModel: rollDiceModel),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ScoreCardDisplay(width: 100, range: 6, scoreCard: _scoreCard, dice: _dice,scoreCardModel: scoreCardModel,onClick: (){
                rollDiceModel.resetRemainingRolls();
                _dice.clear();
                for(var i=0;i<color.length;i++){
                  color[i] = false;
                }
                dialogBox(scoreCardModel);
              },),
            ScoreCardDisplay(width: 140, range: 7, scoreCard: _scoreCard, dice: _dice,scoreCardModel: scoreCardModel,onClick: (){
                rollDiceModel.resetRemainingRolls();
                _dice.clear();
                for(var i=0;i<color.length;i++){
                  color[i] = false;
                }
                dialogBox(scoreCardModel);
              },),
          ],
        ),
        SizedBox(height: 20),
        ListenableBuilder(
          listenable: scoreCardModel, 
          builder: (BuildContext context, Widget? child) {
            return Column(
              children: [
                Text('Current score : ${scoreCardModel.total}'),
              ],
            );
          }
        ),
      ]
    );
  }

  void dialogBox(ScoreCardModel scoreCardModel){
    if(_scoreCard.completed){
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Game Over!'),
          content: Padding(
            // padding: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            child: Text('Your score is ${_scoreCard.total}'),
          ),
            actions: [
            ElevatedButton(
                child: Text("Play Again"),
                onPressed: () {
                  _scoreCard.clear();
                  scoreCardModel.updateTotal(_scoreCard.total);
                  Navigator.of(context).pop();
                })
          ],
        );
      });
    }
  }

}
