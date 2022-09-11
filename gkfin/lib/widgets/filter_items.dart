import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import '../providers/records.dart';
import '../providers/record.dart';
import '../utils/filter.dart';

class FilterItems extends StatefulWidget {
  FilterItems ( {Key? key} ) : super(key:key);

  @override
  _FilterItems createState() => _FilterItems();
}

class _FilterItems extends State<FilterItems>{




  // int _activeFilter = 0;
  
  // Dialog with stateful widgets
  // Ref: https://www.youtube.com/watch?v=Fd5ZlOxyZJ4
  // void onChangeRadioValue(int newVal) {
  //   //update Home context by Provider Records
  //   setState((){
  //   _activeFilter = newVal;
  //   });
  // }
  // Future<void> showDialogFilter(BuildContext context) async {
  //   return await showDialog(context: context,
  //     builder:(context) {
  //       return AlertDialog(
  //         content: Column(
  //           Radio(value: 0, groupValue: _activeFilter, onChanged: onChangeRadioValue),
  //           Radio(value: 1, groupValue: _activeFilter, onChanged: onChangeRadioValue),
  //           Radio(value: 2, groupValue: _activeFilter, onChanged: onChangeRadioValue),
  //           Radio(value: 3, groupValue: _activeFilter, onChanged: onChangeRadioValue),            
  //         ),
  //         actions: <Widget> [
  //           IconButton(
  //             icon: const Icon(Icons.check_sharp),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
              
  //           ),
  //         ]
  //       );
  //     }
  //   );
  // }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // void onChangeRadioValue(int newVal) {
  //   //update Home context by Provider Records
  //   setState((){
  //   _activeFilter = newVal;
  //   });
  // }
  
  showDialogFilter(BuildContext context) {
    return  showDialog(context: context,
    builder: (context){
      String activeFilter = Provider.of<Records>(context,).getFilter();
      return StatefulBuilder(builder: (context,setState){
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Radio(value: Filter.ALL, groupValue: activeFilter, onChanged: (value){
                  // onChangeRadioValue;
                  setState((){
                   activeFilter = value!;
                   Provider.of<Records>(context, listen: false).setFilter(activeFilter);
                  //  print(activeFilter);

                  });
                }),
                Radio(value: Filter.PROFIT, groupValue: activeFilter, onChanged: (value){
                  setState((){
                   activeFilter = value!; 
                   Provider.of<Records>(context, listen: false).setFilter(activeFilter);
                  //  print(activeFilter);
                  });
                }),
                Radio(value: Filter.SPENT, groupValue: activeFilter, onChanged: (value){
                  setState((){
                   activeFilter = value!; 
                   Provider.of<Records>(context, listen: false).setFilter(activeFilter);
                  //  print(activeFilter);
                  });
                }),
                Radio(value: Filter.INVEST, groupValue: activeFilter, onChanged: (value){
                  setState((){
                   activeFilter = value!; 
                   Provider.of<Records>(context, listen: false).setFilter(activeFilter);
                  //  print(activeFilter);
                  });
                }),                                      
              ],
            )
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: (){

                  Navigator.of(context).pop(true);

              },
            ),
          ],
        );
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[                  
        const Text('Lançamentos'),
        CupertinoButton(
          onPressed: () async {
            // await showDialogFilter(context).then((_) => setState((){}));            
            await showDialogFilter(context);
          },
          child: const Icon(Icons.filter_list,
          color: Colors.black54,
          ),
        ),
        // Column(
        //   children: <Widget> [
        //     Radio(value: 0, groupValue: _activeFilter, onChanged: onChangeRadioValue),
        //     Radio(value: 1, groupValue: _activeFilter, onChanged: onChangeRadioValue),
        //     Radio(value: 2, groupValue: _activeFilter, onChanged: onChangeRadioValue),
        //     Radio(value: 3, groupValue: _activeFilter, onChanged: onChangeRadioValue),]
        //   ),
      ],

    );      

  }

}
