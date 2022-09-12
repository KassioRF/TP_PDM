import 'package:flutter/material.dart';


class PickDate extends StatefulWidget {
  const PickDate({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PickDate createState()=>_PickDate();
}

class _PickDate extends State<PickDate> {
  final String _currMonth = 'Setembro de 2022';
  
  @override
  Widget build(BuildContext context) {
    return Row(                
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //@TODO ADD BTN EVENT
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: (){}, 
            icon: const Icon(Icons.keyboard_arrow_left),
          ),
          Text(_currMonth,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 12,
            ),
          ),
          //@TODO ADD BTN EVENT
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: (){},
            icon: const Icon(Icons.keyboard_arrow_right),
          
          ),
        ],

    );
  }
}