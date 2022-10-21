import 'package:flutter/material.dart';
import 'package:gkfin/providers/records.dart';
import 'package:provider/provider.dart';


class PickDate extends StatefulWidget {
  const PickDate({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PickDate createState()=>_PickDate();
}

class _PickDate extends State<PickDate> {
  late String _currMonth;
  late String _currYear;
  late String _currDate;
  @override
  void initState() {
    // TODO: implement initState
    // _currMonth = Provider.of<Records>(context, listen: true).activeMonthYear.month;
    // _currYear = Provider.of<Records>(context, listen: true).activeMonthYear.year;
    super.initState();
    _currMonth = Provider.of<Records>(context, listen: false).activeMonthYear.month;
    _currYear = Provider.of<Records>(context, listen: false).activeMonthYear.year;
    _currDate = "mês $_currMonth/$_currYear";
  }

  Future<void> changeCurrDate(String action) async {
    if (action == 'next') {
      await Provider.of<Records>(context, listen: false).setNextMonth()
      .then((_) {
        setState(() {
          _currMonth = Provider.of<Records>(context, listen: false).activeMonthYear.month;
          _currYear =  Provider.of<Records>(context, listen: false).activeMonthYear.year;
          _currDate = "mês $_currMonth/$_currYear";      
        });
      });
    }else if (action == 'prev') {
      await Provider.of<Records>(context, listen: false).setPreviusMonth()
      .then((_) {
        setState(() {
          _currMonth = Provider.of<Records>(context, listen: false).activeMonthYear.month;
          _currYear =  Provider.of<Records>(context, listen: false).activeMonthYear.year;
          _currDate = "mês $_currMonth/$_currYear";      
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //double balance = Provider.of<Records>(context, listen: true).getBalance();
    
  


    // final PageController controller = PageController();
    return Row(                
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //@TODO ADD BTN EVENT
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              // Provider.of<Records>(context, listen: false).setPreviusMonth();
              changeCurrDate("prev");
              //print("$_currMonth - $_currYear");
            }, 
            icon: const Icon(Icons.keyboard_arrow_left),
          ),
          Text(_currDate,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 12,
            ),
          ),
          //@TODO ADD BTN EVENT
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: (){
              //Provider.of<Records>(context, listen: false).setNextMonth();
              changeCurrDate("next");
              // print("$_currMonth - $_currYear");
            },
            icon: const Icon(Icons.keyboard_arrow_right),
          
          ),
        ],
    );
  }
}
