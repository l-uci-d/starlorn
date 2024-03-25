


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
import '../global/Globals.dart';
import 'dart:math' as math;


class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}





class _LeaderboardPageState extends State<LeaderboardPage> {

  final  userNameController = TextEditingController();
  late DatabaseReference dbRefInput;
  @override
  void initState() {
    super.initState();
    dbRefInput = FirebaseDatabase.instance.ref().child('Students');
  }
  
  Query dbRef = FirebaseDatabase.instance.ref().child('Scores');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Scores');
  
  Widget listItem({required Map score}) {
    Size screenSize = MediaQuery.of(context).size;
    homeText = homeText.copyWith(fontSize: screenSize.width * 0.04, fontStyle: FontStyle.italic) ;
    headerTextWhite = headerTextWhite.copyWith(fontSize: screenSize.width * 0.10);
    uiText = uiText.copyWith(fontSize: screenSize.width * 0.04, color: darkpurp) ;
    homeSubText = homeSubText.copyWith(color: whiteish, fontSize: screenSize.width * 0.035,);
    
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: 
      
      
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: homeText,
              ),

              Text(
                '${score['name']}',
                style: uiText,
              ),
              
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Final mult',
                style: homeText,
              ),
              Text(
                '${score['final mult']}',
                style: uiText,
              ),
                       
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Final Score',
                style: homeText,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${score['score']}',
                style: uiText,
              ),
              
            ],
          ),
        ],
      ),
    );
  }


 
  @override
  Widget build(BuildContext context) {
    

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
                        Row(children: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: darkpurp
                              
                            ),
                            onPressed: () {
                              Navigator.of(context).popUntil(ModalRoute.withName('/'));
                            }, 
                            child: Text('<-', style: homeSubText),
                          ),
                          Expanded(child: 
                          Center(child: Text('leaderboards', style: headerTextPurp),
                          )
                          ),
                        ],
                        ),
                        
                        const Spacer(),
                        
                        Container( 
                        height: screenSize.height * 0.5,
                        width: screenSize.width * 0.9,
                        
                          padding: const EdgeInsets.all(15),
                      child: FirebaseAnimatedList(
                        query: dbRef,
                        itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                          Map score = snapshot.value as Map;
                          score['key'] = snapshot.key;

                          return listItem(score: score);
                        },
                      ),
                    ),
                    Row(
                      children: <Widget>[
                            TextField(
                    controller: userNameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter Your Name',
                    ),
                    ),
                    MaterialButton(
                onPressed: () async {
                  int highScore = await getHighScoreHard();
                  int highMult = await getMultHard();
                  String finalMult = highMult.toString();
                  String finalScore = highScore.toString();
                  Map<String, String> scores = {
                    'name': userNameController.text,
                    'final mult' : finalMult,
                    'score': finalScore
                  };
 
                  dbRefInput.push().set(scores);
 
                },
                child: const Text('Insert Data'),
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 300,
                height: 40,
              ),

                    ],)
              ])
        ))]))));
  }
}