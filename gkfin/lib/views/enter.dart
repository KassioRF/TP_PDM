import 'package:flutter/material.dart';
import 'package:gkfin/widgets/bg_clipper.dart';

// ignore: must_be_immutable
class ClipPathBg extends StatelessWidget {
  const ClipPathBg({
    super.key,
    required this.waveDeep,
    required this.waveDeep2,
    required this.bottom,
    required this.opacity,
    required this.height,
  });

  // ignore: prefer_typing_uninitialized_variables
  final double waveDeep;
  // ignore: prefer_typing_uninitialized_variables
  final double waveDeep2;
  // ignore: prefer_typing_uninitialized_variables
  final double bottom;
  // ignore: prefer_typing_uninitialized_variables
  final double opacity;
    // ignore: prefer_typing_uninitialized_variables
  final double height;


  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(waveDeep: waveDeep, waveDeep2: waveDeep2),
      child: Container(
        padding: EdgeInsets.only(bottom: bottom),
        color: Colors.green.withOpacity(opacity),
        height: height,
        alignment: Alignment.center,
        
      ),      
    );
  }
}

class EnterView extends StatelessWidget {
  const EnterView({super.key, required this.title, required this.form});
  

  final Widget form;
  final String title;


  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    // width = width - width*.05;
    // height = height - height*.50;
    return Scaffold(
      // Defines background color as primary color of MyApp ThemeData
      //backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).backgroundColor,
      //prevent resize when keyboard shows up
      resizeToAvoidBottomInset: false,
      
      body: Column(
        // ClipPathBg(),
        children: <Widget>[
          Stack(
            children: const <Widget>[
              ClipPathBg(waveDeep: 15, waveDeep2: 25, bottom: 50, opacity: .3, height: 175,),
              ClipPathBg(waveDeep: 0, waveDeep2: 50, bottom: 450, opacity: .8, height: 180,),
            ],
          ),
          Container(
            // alignment: Alignment.center,
            padding: const EdgeInsets.only(left:45.0, right:45.0, bottom:0, top: 15 ),
            child:form,
          // Padding(
            // ),
          ),
        ],
      ),
    );
  }
}