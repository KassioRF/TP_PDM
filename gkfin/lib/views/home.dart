// Referência usada: https://github.com/td-santos/Finance_App_Flutter

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  
  final String _currMonth = 'Setembro de 2022';


  int _bottomNavId = 0;
  // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // text?: (Hello, User?)
        actions: [
          IconButton(onPressed: () {}, 
          // move icon to left
          // add option here
          icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),

      // Componentizar!
      body: SingleChildScrollView(
        primary: false,
        //physics: const NeverScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(top:25,),
          child: Column(
            children: <Widget>[
              Row(
                //options to use here: Sizedbox, crossAxisAlignment
                
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  //proft
                  Column(
                    children: <Widget>[
                      // Icon(Icons.keyboard_double_arrow_up_sharp), // alternativa
                      Icon(Icons.arrow_downward),
                    ],
                  ),
                  // balance
                  Column(
                    children: <Widget>[
                      Icon(Icons.currency_exchange_sharp),

                    ],
                  ),
                  // spent
                  Column(
                    children: <Widget>[
                      // Icon(Icons.keyboard_double_arrow_up_sharp), alternativa
                      Icon(Icons.arrow_upward),

                    ],
                  ),
                ], 
              ),
              
              Divider(indent: 15, endIndent: 15, height: 35,),
              // Slide month
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                    IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_left)),
                    Text(_currMonth,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_right)),
                  // Text(_curretMonth,),
                ],
              ),
              
              Divider(indent: 15, endIndent: 15, height: 35,),
              // Transactions
              Text('ue?'),
              Row(
                //widget data table
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Lançamentos'),
                      IconButton(onPressed: (){}, icon: Icon(Icons.filter_list)),
                    ],
                  ),
                ],
                //options to use here: Listview


              ),
            ],
          ),
        ),
      ),
      
      // add regiter
      floatingActionButton: FloatingActionButton(
        
        child: const Icon(Icons.add), // cuidado com esse const!
        onPressed: (){},
      ),

      // bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavId,
        // fixedColor: Colors.teal,
        items: [
          BottomNavigationBarItem(label: 'recetias/despesas', icon: Icon(Icons.currency_exchange_rounded),),
          BottomNavigationBarItem(label: 'investimentos', icon: Icon(Icons.data_exploration_outlined),)
          // Alternataive icons
          // BottomNavigationBarItem(label: 'investimentos', icon: Icon(Icons.bar_chart_rounded),)          
          // BottomNavigationBarItem(label: '', icon: Icon(Icons.add_circle_outline_sharp),),
          // BottomNavigationBarItem(label: '', icon: Icon(Icons.home),),
          // BottomNavigationBarItem(label: '', icon: Icon(Icons.remove_circle_outline_sharp),),
        ],
        onTap: (int index) {
          setState((){
            _bottomNavId = index;
          });
        },
      ),
    );
  }
}