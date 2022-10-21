import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/records.dart';
import '../utils/filter.dart';


// default box decoration 
final _boxDecoration =  BoxDecoration(
  borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(.05),
        offset: const Offset(0,3),
      )
    ]
);


class HomeOverView extends StatefulWidget {
  const HomeOverView({ Key?key , required this.filter}) : super(key:key);

  final String filter;

  @override
  // ignore: library_private_types_in_public_api
  _HomeOverView createState()=> _HomeOverView();
}

class _HomeOverView extends State<HomeOverView> {
  @override
  Widget build(BuildContext context) {
    // double allSpent = Provider.of<Records>(context, listen: false).getAllSpent();
    // double allProfit = Provider.of<Records>(context, listen: false).getAllProfit();
    // double allInvest = Provider.of<Records>(context, listen: false).getAllInvest();
    // double balance = Provider.of<Records>(context, listen: false).getBalance();
    double allSpent = Provider.of<Records>(context, listen: true).getAllSpent();
    double allProfit = Provider.of<Records>(context, listen: true).getAllProfit();
    double allInvest = Provider.of<Records>(context, listen: true).getAllInvest();
    double balance = Provider.of<Records>(context, listen: true).getBalance();

    return widget.filter != Filter.INVEST ? // Show's OverView for Spent/Proft's
      Column(
        children: <Widget>[
          //Saldo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Make an Widget "clickable" with InkWell
              // ref: https://stackoverflow.com/questions/43692923/flutter-container-onpressed
              // Answered by @CopsOnRoad
              InkWell(
                onTap: (){
                  Provider.of<Records>(context, listen: false).setFilter(Filter.ALL);
                  // print('set provider: filter value');
                },                
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const  EdgeInsets.only(top:10),
                      child: const  Text('Saldo', style: TextStyle(fontSize: 13) ),

                    ),              
                    Row(
                      children: <Widget>[
                        Container(                
                          padding: const EdgeInsets.fromLTRB(5, 10, 10, 5),
                          decoration: _boxDecoration,
                          child: Text(
                            "\$ ${balance}" ,
                            style: TextStyle (
                              //color: Colors.blue.withOpacity(1),
                              color: balance >= 0 ?  Colors.blue.withOpacity(1) : Colors.redAccent.withOpacity(.8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(Icons.currency_exchange_sharp, color: balance >= 0 ? Colors.blue : Colors.redAccent, size: 16,),
                        //const Icon(Icons.currency_exchange_sharp, color: Colors.blue, size: 16,),
                        
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Receita despesa
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //proft
              InkWell(
                onTap: (){
                  Provider.of<Records>(context, listen: false).setFilter(Filter.PROFIT);
                  // print('set provider: filter value');
                },
                child: Column(
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
                            "\$ ${allProfit}",
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
              ),
              // spent
              InkWell(
                onTap: (){
                  Provider.of<Records>(context, listen: false).setFilter(Filter.SPENT);
                  // print('set provider: filter value');
                },              
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    // Icon(Icons.keyboard_double_arrow_up_sharp), alternativa
                    const Text('Despesas', style: TextStyle(fontSize: 13), ),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.arrow_downward, color: Colors.redAccent, size: 22,),
                        Container(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                          decoration: _boxDecoration,
                          child: Text(
                            "\$ ${allSpent}",
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
              ),                  
            ],          
          ),
        ],
      )
      
      : // Show's OverView for Invets

      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: (){
                  // Provider.of<Records>(context, listen: false).setFilter(Filter.ALL);
                  // print('set provider: filter value');
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const  EdgeInsets.only(top:10),
                      child: const  Text('Investimentos', style: TextStyle(fontSize: 13) ),

                    ),              
                    Row(
                      children: <Widget>[
                        Container(                
                          padding: const EdgeInsets.fromLTRB(5, 10, 10, 5),
                          decoration: _boxDecoration,
                          child: Text(
                            "\$ ${allInvest}",
                            style: TextStyle (
                              color: Colors.deepPurple.withOpacity(1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Icon(Icons.stacked_bar_chart, color: Colors.deepPurple,),
                        
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),          
        ],
      );
  }
}
