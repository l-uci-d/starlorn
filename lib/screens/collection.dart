import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:starlorn/global/Animations.dart';
import 'package:starlorn/models/CardGrid.dart';
import 'package:starlorn/models/Collections.dart';
import 'package:starlorn/models/Mechanics.dart';
import '../global/Globals.dart';
import 'dart:math' as math;


class ProgressionGauge extends StatefulWidget {
  const ProgressionGauge({super.key});

  @override
  State<ProgressionGauge> createState() => _ProgressionGauge();
}



  late Collection collection;
  late Duration duration;



class _ProgressionGauge extends State<ProgressionGauge> {



  @override
  void initState() {
      super.initState();         
      collection = Collection(context);     
                          
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
                            child: Text('←', style: homeSubText),
                          ),
                          Expanded(child: 
                          Center(child: Text('collection', style: headerTextPurp),
                          )
                          ),
                        ],
                        ),
                        
                        const Spacer(),
                        

                        const Spacer(),

                        Container( 
                          height: screenSize.height * 0.8,
                          padding: const EdgeInsets.all(15),
                          child: 
                            GridView.count(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                crossAxisSpacing: 15.0,
                                mainAxisSpacing: 15,
                                childAspectRatio: 0.35,
                                children: 
                              List.generate(collection.CollectionCards.length, (index) {
                                return CollectionGrid(
                                  index: index,
                                  card: collection.CollectionCards[index],
                                  onCardPressed: collection.onTapped,
                                );
                              } 
                              )
                            )
                        ) ,
                          const Spacer()
                        ],
                      )
                    )
                  )
                ]
              )
            )
          )
        );
  }
}



