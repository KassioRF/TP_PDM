// Referência usada: https://github.com/td-santos/Finance_App_Flutter

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/records.dart';
import '../data/dummy_data.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomeView> with SingleTickerProviderStateMixin {
  
  final String _currMonth = 'Setembro de 2022';
  late TabController _tabController;
  int _bottomNavId = 0;
  List<Record> _mockData = DUMMY_RECORDS;
  
  @override
  void initState(){
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }
  // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        leading: IconButton( icon: Icon(Icons.account_circle, size:40), onPressed: () {},),
        title: Text('Hello, User'),
        actions: [
          IconButton( icon: const Icon(Icons.more_vert), onPressed: () {},)
        
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget> [
            Tab(icon: Icon(Icons.currency_exchange_rounded)),
            Tab(icon: Icon(Icons.stacked_bar_chart, size: 32.0)),
          ],
        ),
      ),

      body: Column(
          children: <Widget>[
            //Componentizar os containers! 1 Widget pra cada divisão
            //header
            Container (
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top:40,),
            //@TODO Convert to card ?
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ),
          
          Divider(indent: 15, endIndent: 15,),
          // Data slider
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
            ],
          ),
          Divider(indent: 15, endIndent: 15, height: 15,),
          // Records by month
          
          ListView.builder(
            // shrinkWrap: true,
            itemCount: _mockData.length,
            itemBuilder: (BuildContext context, int index) {
              return Expanded(
                child: Column(children: [
                  Text("item $index"),Text("item $index"),Text("item $index"),Text("item $index")
                ]),
              );
            },            
          ),
          
          // ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: _mockData.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return Expanded(
          //       child: Column(children: [
          //         Text("item $index"),Text("item $index"),Text("item $index"),Text("item $index")
          //       ]),
          //     );
          //   },            
          // ),
          // Row(
          //   children: <Widget>[

          //   ],
          // )


        ],
      ),

      // ref: https://stackoverflow.com/questions/59455684/how-to-make-bottomnavigationbar-notch-transparent
      //FAB add register
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add), // cuidado com esse const!
        onPressed: (){},

      ),       
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //Bottom bar
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4,
        color: Theme.of(context).primaryColor,
        child: Container(height: 40,)

      ),

    );

  
  }
}