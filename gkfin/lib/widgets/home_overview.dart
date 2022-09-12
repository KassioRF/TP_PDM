import 'package:flutter/material.dart';








// default box decoration 
final _boxDecoration =  BoxDecoration(
  borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(.05),
        offset: Offset(0,3),
      )
    ]
);


class HomeOverView extends StatefulWidget {
  const HomeOverView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeOverView createState()=> _HomeOverView();
}

class _HomeOverView extends State<HomeOverView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        //proft
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Icon(Icons.keyboard_double_arrow_up_sharp), // alternativa
            const Text('Receitas', style: TextStyle(fontSize: 13)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                  decoration: _boxDecoration,
                  child: Text(
                    '\$ 255.55',
                    style: TextStyle (
                      color: Colors.green.withOpacity(1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            const Icon(Icons.arrow_upward, color: Colors.green, size: 22,),
              ],
            ),

          ],
        ),
        // balance
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const  EdgeInsets.only(top:10),
              child: const  Text('Saldo', style: TextStyle(fontSize: 13) ),

            ),
            
            Row(
              children: [
                Container(                
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                  decoration: _boxDecoration,
                  child: Text(
                    '\$ 255.55',
                    style: TextStyle (
                      color: Colors.blue.withOpacity(1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(Icons.currency_exchange_sharp, color: Colors.blue, size: 16,),
                
              ],
            ),

          ],
        ),
        // spent
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            // Icon(Icons.keyboard_double_arrow_up_sharp), alternativa
            Text('Despesas', style: TextStyle(fontSize: 13) ),
            Row(
              children: <Widget>[
                const Icon(Icons.arrow_downward, color: Colors.redAccent, size: 22,),
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                  decoration: _boxDecoration,
                  child: Text(
                    '\$ 255.55',
                    style: TextStyle (
                      color: Colors.red.withOpacity(1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ],
    );
  }
}
