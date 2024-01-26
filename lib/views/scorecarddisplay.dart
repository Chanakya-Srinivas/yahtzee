import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mp2/models/dice.dart';
import 'package:mp2/models/scorecard.dart';
import 'package:mp2/models/scorecardmodel.dart';

class ScoreCardDisplay extends StatelessWidget{

  final ScoreCard scoreCard;
  final Dice dice;
  final double width;
  final int range;
  final ScoreCardModel scoreCardModel;
  final VoidCallback? onClick;

  const ScoreCardDisplay({required this.scoreCard,required this.dice,required this.width,required this.range,required this.scoreCardModel,this.onClick,super.key});

  
  @override
  Widget build(BuildContext context) {
    return Container(
          width: width + 55,
          height: 200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: width,
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(range, (i){
                    return Row(
                      children: [
                      
                        Text('${ScoreCategory.values[(range==7)?i+6:i].name} :'),
                      ],
                    );
                  })
                  ),
              ),
              Container(
                width: 55,
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(range, (i){
                    return ListenableBuilder(listenable: scoreCardModel, 
                    builder:(BuildContext context, Widget? child) {
                      return Row(
                        children: [
                          Container(
                            child: RichText(
                            text: TextSpan(
                              text: (scoreCard[ScoreCategory.values[(range==7)?i+6:i]]==null) ? 'Pick' :'${scoreCard[ScoreCategory.values[(range==7)?i+6:i]]}',
                              style: (scoreCard[ScoreCategory.values[(range==7)?i+6:i]]==null) ? TextStyle(color: Colors.blue) : TextStyle(color: Colors.black),
                              recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if(dice.values.isNotEmpty && scoreCard[ScoreCategory.values[(range==7)?i+6:i]]==null) {
                                  scoreCard.registerScore(ScoreCategory.values[(range==7)?i+6:i], dice.values);
                                  scoreCardModel.updateTotal(scoreCard.total);
                                  onClick!();
                                }
                              }
                            ),
                          ),
                          )
                        ],
                      );
                    });
                    
                  })
                  ),
              ),
            ],
          ),
        );
  }

}