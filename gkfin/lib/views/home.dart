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
  final List<Record> _mockData = DUMMY_RECORDS;
  
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
        //@TODO ADD BTN EVENT
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.account_circle, size:40),),
        title: Text('Hello, User'),
        actions: [
          //@TODO ADD BTN EVENT
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert),)
        
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget> [
            Tab(icon: Icon(Icons.currency_exchange_rounded)),
            Tab(icon: Icon(Icons.stacked_bar_chart, size: 32.0)),
          ],
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex:2,
              //Componentizar os containers! 1 Widget pra cada divisão
              //header
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //proft
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Icon(Icons.keyboard_double_arrow_up_sharp), alternativa
                      Icon(Icons.arrow_upward),

                    ],
                  ),
                ],
              ),
            ),
              // Data slider
            Divider(indent: 15, endIndent: 15,),
            Expanded(
              flex: 1,
              child: Row(                
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //@TODO ADD BTN EVENT
                  IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_left)),
                  Text(_currMonth,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    ),
                  ),
                  //@TODO ADD BTN EVENT
                  IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_right)),
                ],
              ),
            ),
            Divider(indent: 15, endIndent: 15, height: 15,),
            
            //Records Filters
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Lançamaentos'),
                  IconButton(
                    onPressed: (){},                    
                    //@TODO ADD BTN EVENT
                    icon: IconButton(onPressed: (){}, icon: Icon(Icons.filter_list),)
                  )
                ]
              ),
            ),
            
            // ListView dentro de Cloumn: https://www.youtube.com/watch?v=Gylc2SiLxmE
            Divider(indent: 15, endIndent: 15, height: 15,),
            Expanded(
              flex: 9,
              child: ListView.builder(
                // shrinkWrap: true,
                itemCount: _mockData.length*3,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item $index')
                    // child: Column(children: [
                    //   Text("item $index"),Text("item $index"),Text("item $index"),Text("item $index")
                    // ]),
                  );
                },            
              ),
            ),
          ],

        ),
      ),
      // ref: https://stackoverflow.com/questions/59455684/how-to-make-bottomnavigationbar-notch-transparent
      //FAB add register
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add), // cuidado com esse const!
        //@TODO ADD BTN EVENT
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