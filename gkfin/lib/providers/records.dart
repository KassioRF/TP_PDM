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
    return [..._items];
  }

  void addRecord(Record record) {
    _items.add(record);
    notifyListeners();
  }

  void undoDelete(int index, Record record,) {
    _items.insert(index, record);
    notifyListeners();
  }

  void removeRecord(int index) {
    _items.removeAt(index);
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

}
