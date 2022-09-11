// Referência usada:https://www.youtube.com/watch?v=xaihraUqkcM

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import '../providers/records.dart';
import '../providers/record.dart';



// default box decoration 


class ListRecords extends StatefulWidget {
  const ListRecords( {Key? key } ) : super(key:key);

  @override
  // ignore: library_private_types_in_public_api
  _ListRecords createState() => _ListRecords();
}

class _ListRecords extends State<ListRecords>{
  // Records recordsProvider = Records();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getCurrentFilter();
  }

  void getCurrentFilter() async {
    // String activeFilter = recordsProvider.getFilter();
  }

  void refresh(){
    setState(() {});
  }  


  @override
  Widget build(BuildContext context) {
    // show proft only, or spent,  or invest;
    // final filter, const? enum ?
    final recordsProvider = Provider.of<Records>(context);
    final records = recordsProvider.items;

    return ListView.builder (
      padding: EdgeInsets.all(5.0),
      itemCount: records.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: records[i],
        child: ListRecordsItem(index: i, refresh: refresh),
      ),
    );
  }


}


// ignore: must_be_immutable
class ListRecordsItem extends StatefulWidget {
  // const ListRecordsItem ({super.key,required this.index});
  final int index;
  VoidCallback refresh;

  ListRecordsItem ({ Key? key, required this.index, required this.refresh} ): super(key:key);
  @override
  // ignore: library_private_types_in_public_api
  _ListRecordsItem createState() => _ListRecordsItem();

}

class _ListRecordsItem extends State<ListRecordsItem> {
  @override
  void initState() {
    super.initState();
  }

  // Show snackbar when onDismissed list item
  void showSnackBar(context,index) {
    Record record = Provider.of<Records>(context).items[index];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${record.desc} removido"),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: "desfazer",

          onPressed: (){
            Provider.of<Records>(context, listen: false).undoDelete(index, record);
          },
        ),
      ),
    );
  }

  @override
  Widget build (BuildContext context) {
    // final recordsProvider = Provider.of<Records>(context);
    // final records = recordsProvider.items;
    final records = Provider.of<Records>(context,).items;

    Color color;
    String value;
    Icon icon;

    if (records[widget.index].type == 'spent') {
      color = Colors.red;
      value = "- ${records[widget.index].value}";
      icon = Icon(Icons.arrow_downward, color: color);
    
    }else if (records[widget.index].type == 'profit') {
      color = Theme.of(context).primaryColor;
      value = "+ ${records[widget.index].value}";
      icon = Icon(Icons.arrow_upward, color: color);
    
    }else {
      color = Colors.blue;
      value = "+ ${records[widget.index].value}";
      icon = Icon(Icons.arrow_upward, color: color);
    }


    return Dismissible(
      key:  UniqueKey(),
      onDismissed: (direction) {
        showSnackBar(context, widget.index);
        setState((){
        Provider.of<Records>(context, listen: false).removeRecord(widget.index);
        // refresh to prevent index error when record list it's updated
        // ref: https://stackoverflow.com/questions/62011871/flutter-index-out-of-range-when-i-try-to-delete-an-item-from-a-list
        widget.refresh();
        });
      },
      child: Card (
        child: ListTile(
          leading: icon,
          title: Text(
            records[widget.index].desc,
            style: TextStyle(color: color),
          ),
          trailing: Text(
            value,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      
    );

  } 

  
}
