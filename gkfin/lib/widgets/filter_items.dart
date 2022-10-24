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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  showDialogFilter(BuildContext context) {
    return  showDialog(context: context,
    builder: (context){
      
      return StatefulBuilder(builder: (context,setState){
        String activeFilter = Provider.of<Records>(context).getFilter();
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RadioListTile(
                  title: const Text('todos'),
                  value: Filter.ALL, 
                  groupValue: activeFilter, 
                  onChanged: (value){
                    Provider.of<Records>(context, listen: false).setFilter(value!);
                  },                  
                ),
                RadioListTile(
                  title: const Text('receitas'),
                  value: Filter.PROFIT, 
                  groupValue: activeFilter, 
                  onChanged: (value){
                    Provider.of<Records>(context, listen: false).setFilter(value!);
                  },                  
                  
                ),
                RadioListTile(
                  title: const Text('despesas'),
                  value: Filter.SPENT, 
                  groupValue: activeFilter,                   
                  onChanged: (value){                  
                    Provider.of<Records>(context, listen: false).setFilter(value!);
                  },                                    
                ),

              ],
            )
          ),
          actions: <Widget>[
              IconButton(onPressed: (){ Navigator.of(context).pop(true); },
              icon: const Icon(Icons.check_sharp),
              // Navigator.of(context).pop(true);
            ),
          ],
        );
      });
    });

  }





  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[                  
        Expanded(
          child: IconButton(
            onPressed: () async {
              // await showDialogFilter(context).then((_) => setState((){}));            
              if (Provider.of<Records>(context, listen: false).getFilter() != Filter.INVEST) {
                await showDialogFilter(context);
              }
            },
          icon: const Icon(Icons.filter_list, color: Colors.black54,),
          ),
        ),      
      ],
    );      

  }

}
