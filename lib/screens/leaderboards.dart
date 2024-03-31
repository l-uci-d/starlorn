
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:starlorn/global/Animations.dart';
import 'package:starlorn/models/CardGrid.dart';
import 'package:starlorn/models/Collections.dart';
import 'package:starlorn/models/Mechanics.dart';
import 'package:starlorn/widgets/AlertDialogs.dart';
import '../global/Globals.dart';
import 'dart:math' as math;


class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

bool isHardMode = false;



class _LeaderboardPageState extends State<LeaderboardPage> {
  
  final  userNameController = TextEditingController();
  late DatabaseReference dbRefInput;
  late Query dbRef;
  late DatabaseReference reference;
  late String difficulty;
  late int highMult = 0;
  late int highScore = 0;


  
  @override
  void initState() {
    super.initState();
    
    fetchData();
    
  }

  Future<void> fetchData() async {
    difficulty = isHardMode ? 'Hard' : 'Easy';
    dbRef = FirebaseDatabase.instance.ref().child('Scores/$difficulty');
    dbRefInput = FirebaseDatabase.instance.ref().child('Scores/$difficulty');
    dbRef = FirebaseDatabase.instance.ref().child('Scores/$difficulty');
    reference = FirebaseDatabase.instance.ref().child('Scores/$difficulty');

    if(isHardMode)
      {
      highScore = await getHighScoreHard();
      highMult = await getMultHard();
      }
    else
      {
      highScore = await getHighScoreEasy();
      highMult = await getMultEasy();
      }

      
  }
  
  
  Widget listItem({required Map score, required int index}) {
    Size screenSize = MediaQuery.of(context).size;
    homeText = homeText.copyWith(fontSize: screenSize.width * 0.04, fontStyle: FontStyle.italic) ;
    headerTextWhite = headerTextWhite.copyWith(fontSize: screenSize.width * 0.10);
    uiText = uiText.copyWith(fontSize: screenSize.width * 0.04, color: darkpurp) ;
    homeSubText = homeSubText.copyWith(color: whiteish, fontSize: screenSize.width * 0.035,);
    
    return Container(

      padding: const EdgeInsets.all(10),
      child: 
      
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$index.)',
                  style: uiText,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16), 
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${score['name']}',
                  style: uiText,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16), 
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${score['final mult']}',
                  style: uiText,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16), 
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${score['score']}',
                  style: uiText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  
 
  @override
  Widget build(BuildContext context) {
    fetchData();
    

    Size screenSize = MediaQuery.of(context).size;
    homeText = homeText.copyWith(fontSize: screenSize.width * 0.07, fontStyle: FontStyle.italic) ;
    headerTextWhite = headerTextWhite.copyWith(fontSize: screenSize.width * 0.13);
    uiText = uiText.copyWith(fontSize: screenSize.width * 0.04, color: darkpurp) ;
    homeSubText = homeSubText.copyWith(color: whiteish, fontSize: screenSize.width * 0.035,);
  
    return MaterialApp(

      
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_collection.png'),
              fit: BoxFit.cover,
            ),
          ),
          child:  
            Stack(
              alignment: Alignment.topLeft,
              
              children: <Widget>[
                BgAnim(null, 'stars_negative'),
                
              Padding(padding: EdgeInsets.all(screenSize.width * 0.06),
              child: 
                Center(
                  child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Spacer(),
                        Row(children: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: darkpurp
                              
                            ),
                            onPressed: () {
                              Navigator.of(context).popUntil(ModalRoute.withName('/'));
                            }, 
                            child: Text('←', style: homeSubText),
                          ),
                          Expanded(child: 
                          Center(child: Text('leaderboards', style: headerTextPurp),
                          )
                          ),
                        ],
                        ),

                        Row( mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Switch(
                              value: isHardMode,
                              onChanged: (value) {
                                setState(() {
                                  isHardMode = value;
                                });
                                
                                 fetchData();
                              },
                              activeColor: magenta,
                            ),
                            Text('Looking at $difficulty scores', style: uiText,),
                          ],
                        )
                        ,
                        const Spacer(),
                        
                        Container( 
                        width: screenSize.width * 0.75,
                        decoration: BoxDecoration(
                          border: Border.all(color: magenta),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        
                        padding: const EdgeInsets.all(15),
                        child: 
                        Column(
                          children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'rank',
                                      style: uiText.copyWith(fontFamily:'Bayer-TypeArchiType' ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16), 
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'name',
                                      style: uiText.copyWith(fontFamily:'Bayer-TypeArchiType' ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16), 
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'final mult',
                                      style: uiText.copyWith(fontFamily:'Bayer-TypeArchiType' ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16), 
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'final score',
                                      style: uiText.copyWith(fontFamily:'Bayer-TypeArchiType' ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: magenta,
                            thickness: 1.5,
                            height: 1
                          ),

                          SizedBox(
  height: screenSize.height * 0.5,
  width: screenSize.width * 0.95,
  child: FutureBuilder(
    future: fetchData(),
    builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                query: dbRef.orderByChild('order'),
                
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                  if (snapshot.value != null && snapshot.value is Map<dynamic, dynamic>) {
                    Map<dynamic, dynamic> score = snapshot.value as Map<dynamic, dynamic>;
                    score['key'] = snapshot.key;
                    int reversedIndex = index++;

                    return listItem(score: score, index: reversedIndex);
                  } else {
                    return Container(); 
                  }
                },
              ),
            ),
          ],
        );
      }
    },
  ),
)

                        ],)
                    ),
                    const Spacer(),

                    Row( mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                            SizedBox(
                              width: screenSize.width * .5,
                              child: 
                              Column(children: <Widget>[
                              TextField(
                                controller: userNameController,
                                keyboardType: TextInputType.text,
                                decoration:  InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'Name',
                                  hintText: 'Enter Your Username',
                                  labelStyle: uiText,

                                ),
                              ),
                              FutureBuilder(future: fetchData(), builder: 
                              (BuildContext context, AsyncSnapshot<void> snapshot){
                                return Column(children: [
                                Text('Final High Score: $highScore', style: uiText,),
                                Text('Final Mult: $highMult', style: uiText,),

                              ],);
                              }
                               )
                             ,
                              MaterialButton(
                                onPressed: () async {
                                  late String finalMult;
                                  late String finalScore;
                                  late String order;
                                   finalMult = highMult.toString();
                                   finalScore = highScore.toString();
                                   order = (99999999999999-highScore).toString();

                                   
                                   
                                  Map<String, String> scores = {
                                    'name': userNameController.text,
                                    'final mult' : finalMult,
                                    'score': finalScore,
                                    'order' : order


                                  };
                
                                  bool dataExists = await checkExistingData(scores);
                                    if (!dataExists && userNameController.text.length <=10) {
                                      dbRefInput.push().set(scores);
                                    
                                      
                                    } 
                                    else if(userNameController.text.length > 10){
                                    scoreError = false;
                                    showWarning(context);
                                   }
                                    
                                    else {
                                      scoreError=true;
                                      showWarning(context);
                                      print('Similar data already exists. Not pushing.');
                                    }
                
                                },
                                
                                color: lightpurp,
                                minWidth: 300,
                                height: 40,
                                child:  Text('Upload your $difficulty \nHigh Score', style: uiText.copyWith(color: whiteish)
                                ,textAlign: TextAlign.center,),
                              ),
                              ]
                              )
                            )

                    ],),
              const Spacer(),
              ])
        ))]))));
  }
  Future<bool> checkExistingData(Map<String, String> newData) async {
  DatabaseEvent event = await dbRefInput.once();

  DataSnapshot snapshot = event.snapshot;

  Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;

  if (values != null) {
    for (var value in values.values) {
      if (value is Map<dynamic, dynamic> &&
          value['name'] != null &&
          value['final mult'] != null &&
          value['score'] != null &&
          value['name'] == newData['name'] &&
          value['final mult'] == newData['final mult'] &&
          value['score'] == newData['score']) {
        return true; 
      }
    }
  }

  return false; 
}
}