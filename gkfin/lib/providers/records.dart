import 'package:flutter/cupertino.dart';
import 'record.dart';
import '../data/dummy_data.dart';

//Change notifier: implementação do padrão Observer
class Records with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Record> _items = DUMMY_RECORDS;

  List<Record> get items {
    return [ ... _items];
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
}
