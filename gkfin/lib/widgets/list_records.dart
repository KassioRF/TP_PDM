// Referência usada:https://www.youtube.com/watch?v=xaihraUqkcM

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import '../providers/records.dart';
import '../providers/record.dart';

// default box decoration 


class ListRecords extends StatefulWidget {
  const ListRecords( {Key? key} ) : super(key:key);

  @override
  // ignore: library_private_types_in_public_api
  _ListRecords createState() => _ListRecords();
}

class _ListRecords extends State<ListRecords>{
  // Records recordsProvider = Records();
  @override
  void initState() {
    super.initState();
  }


  void refresh(){
    setState(() {});
  }  

  @override
  Widget build(BuildContext context) {
    return Consumer<Records>(
      builder: (ctx, records, child) {
        // records.setFilter(widget.filter);
        return ListView.builder(
          itemCount: records.items.length,
          itemBuilder: (ctx, i) => 
          ListRecordsItem(index: i, record: records.items[i] ,refresh: refresh)
          ,
        );
      },
    );
  }
}

// ignore: must_be_immutable
class ListRecordsItem extends StatelessWidget {
  final int index;
  final Record record;
  VoidCallback refresh;
  
  ListRecordsItem ({ Key? key, required this.index, required this.record, required this.refresh, } ): super(key:key);

  Widget deleteBgItem() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(Icons.delete, color: Colors.white),
    );
  }

  @override
  Widget build (BuildContext context) {
    Color color;
    String value;
    Icon icon;

    if (record.type == 'spent') {
      color = Colors.red;
      value = "- ${record.value}";
      icon = Icon(Icons.arrow_downward, color: color);
    
    }else if (record.type == 'profit') {
      color = Theme.of(context).primaryColor;
      value = "+ ${record.value}";
      icon = Icon(Icons.arrow_upward, color: color);
    
    }else {
      // color = Colors.blue;
      color = Colors.deepPurple;
      value = "${record.value}";
      icon = Icon(Icons.arrow_upward, color: color);
    }


    return Dismissible(
      key: ValueKey(record.id),
      background: deleteBgItem(),
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const Text("Remover registro?"),
              actions: <Widget>[                
                IconButton(onPressed: (){
                    Navigator.of(context).pop(false); 
                  },               
                icon: const Icon(Icons.close)),
                IconButton(onPressed: (){
                  Provider.of<Records>(context, listen: false).removeRecord(record.id);
                  showSnackBar(context, record);
                  Navigator.of(context).pop(true); 
                  },
                  icon: const Icon(Icons.check_sharp),
                ),
                
              ],
            );
          },
        );
      },      
      onDismissed: (_) async {

      },
      child: Card (
        //@TODO Make smaller items
        child: ListTile(
          leading: icon,
          title: Text(
            record.desc,
            style: TextStyle(color: color),
          ),
          subtitle: Text(
            record.date,
            style: TextStyle(color: Colors.grey.withOpacity(.7), fontSize: 12),
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

// Dialog Elements
// Show snackbar when onDismissed list item
void showSnackBar(context, Record record) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Registro removido"),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
