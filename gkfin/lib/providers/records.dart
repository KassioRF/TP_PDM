import 'package:flutter/cupertino.dart';
import 'record.dart';
import '../data/dummy_data.dart';
import '../utils/filter.dart';

//Change notifier: implementação do padrão Observer
class Records with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Record> _items = DUMMY_RECORDS;

  String filter = Filter.ALL;

  List<Record> get items {
    //return [ ... _items];
    if (filter != Filter.ALL) {
      return _items.where((element) => element.type == filter).toList();
    }
    //return [..._items];
    //exlude invest for all
    return _items.where((element) => element.type != Filter.INVEST).toList();
  }

  void addRecord(Record record) {
    _items.add(record);
    notifyListeners();
  }

  void undoDelete(int index, Record record,) {
    _items.insert(index, record);
    notifyListeners();
  }

  void  removeRecord(int id) {
    // _items.removeAt(index);
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  String getFilter() {
    return filter;
  } 

  void setFilter(String _filter) {
    switch (_filter) {
      case 'all': filter = Filter.ALL; break;
      case 'spent': filter = Filter.SPENT; break;
      case 'profit': filter = Filter.PROFIT; break;
      case 'invest': filter = Filter.INVEST; break;
    }
    notifyListeners();
  }

  double getAllSpent() {
    double val = 0.0;
    for (Record item in _items) {
      if (item.type == 'spent') {
        val += item.value;
      }
    }
    return double.parse((val).toStringAsFixed(2));
  }

  double getAllProfit() {
    double val = 0.0;
    for (Record item in _items) {
      if (item.type == 'profit') {
        val += item.value;
      }
    }
    return double.parse((val).toStringAsFixed(2));
  }

  double getAllInvest() {
    double val = 0.0;
    for (Record item in _items) {
      if (item.type == 'invest') {
        val += item.value;
      }
    }
    return double.parse((val).toStringAsFixed(2));
  }

  double getBalance() {
    double spent = getAllSpent();
    double proft = getAllProfit();
    double balance = proft - spent; 
    return double.parse((balance).toStringAsFixed(2));
  }

}
