import 'package:flutter/material.dart';


class PickDate extends StatefulWidget {
  const PickDate({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PickDate createState()=>_PickDate();
}

class _PickDate extends State<PickDate> {
  // final List<String> test = [
  //   'Abril de 2022',
  //   'Maio de 2022',
  //   'Junho de 2022',
  //   'Julho de 2022',
  //   'Agosto de 2022',
  //   'Setembro de 2022',
  // ];
  final String _currMonth = 'Setembro de 2022';


  @override
  Widget build(BuildContext context) {
    // final PageController controller = PageController();
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

// @TODO test PAgeView.builder()
    // return Row(                
    //     // crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: <Widget>[
    //       //@TODO ADD BTN EVENT
    //       IconButton(
    //         padding: EdgeInsets.zero,
    //         onPressed: (){}, 
    //         icon: const Icon(Icons.keyboard_arrow_left),
    //       ),

    //       SizedBox(
    //         // height: 25,
    //         width: 150,
    //         child: PageView.builder(
    //           controller: controller,
    //           itemBuilder: (context, index) {
    //             return Text(
    //               test[index],
    //               style: const TextStyle(
    //                 fontStyle: FontStyle.italic,
    //                 fontSize: 12,
    //                 backgroundColor: Colors.grey,
    //               ),                                
    //             );
    //           },
    //           scrollDirection: Axis.horizontal,
    //           itemCount: test.length,     
    //         ),
    //       ),
    //       // Text(_currMonth,
    //       //     style: const TextStyle(
    //       //       fontStyle: FontStyle.italic,
    //       //       fontSize: 12,
    //       //     ),
    //       //   ),
    //       //@TODO ADD BTN EVENT
    //       IconButton(
    //         padding: EdgeInsets.zero,
    //         onPressed: (){},
    //         icon: const Icon(Icons.keyboard_arrow_right),
          
    //       ),
    //     ],
    // );
