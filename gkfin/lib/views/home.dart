// Referência usada: https://github.com/td-santos/Finance_App_Flutter

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gkfin/widgets/home_overview.dart';
import 'package:gkfin/widgets/list_records.dart';
import 'package:gkfin/widgets/filter_items.dart';
import 'package:gkfin/widgets/pick_date.dart';
import 'package:gkfin/views/add_register.dart';

// import '../models/records.dart';
import '../data/dummy_data.dart';
import '../models/records.dart';


// default box decoration 
final _boxDecoration =  BoxDecoration(
  borderRadius: BorderRadius.circular(2),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(.1),
        offset: Offset(0,3),
      )
    ]
);


class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomeView> with SingleTickerProviderStateMixin {

  // final String _currMonth = 'Setembro de 2022';
  late TabController _tabController;
  final List _mockData = DUMMY_RECORDS;
  

  @override
  void initState(){
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    // _tabController = TabController(vsync: this, length: 2);
  }
  // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
  //DATA FOR WIDGET REGISTER ITEMS
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
          // unselectedLabelColor: Theme.of(context).backgroundColor,
          // indicator: BoxDecoration(color: Theme.of(context).backgroundColor),
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
              flex:4,
              //Componentizar os containers! 1 Widget pra cada divisão
              //header
              child: HomeOverView(),
            ),
              // Data slider
            // Divider(indent: 15, endIndent: 15,),
            Expanded(
              flex: 1,
              child: Card(
                  child: PickDate(),
              ),
            ),
            
            // Records Filters
            Divider(height: 15,),
            Expanded(
              flex: 1,        
              child: FilterItems(),
            ),
            
            Divider(height: 15,),
            // ListView inside Cloumn:
            // ref: https://www.youtube.com/watch?v=Gylc2SiLxmE
            Expanded(
              flex: 6,              
              child: Container(
                padding: EdgeInsets.all(5.0),
                decoration: _boxDecoration,               
                child: ListRecords(),
                // child: showList(),
              ),
            ),
          ],

        ),
      ),
      //FAB add register
      //ref: https://stackoverflow.com/questions/59455684/how-to-make-bottomnavigationbar-notch-transparent
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add), // cuidado com esse const!
        //@TODO ADD BTN EVENT
        onPressed: (){
          Navigator.of(context).push(_addRegister());
        },

      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //Bottom bar
      bottomNavigationBar: BottomAppBar(
        // shape: CircularNotchedRectangle(),
        shape: CircularNotchedRectangle(),
        notchMargin: 4,
        color: Theme.of(context).primaryColor,
        child: Container(height: 37,)

      ),

    );
  
  }

}

Route _addRegister() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const AddRegister(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}