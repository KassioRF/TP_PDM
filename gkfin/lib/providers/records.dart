import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'record.dart';
//import '../data/dummy_data.dart';
import '../utils/filter.dart';
import 'package:gkfin/utils/date_utils.dart';


// Firebase tests
import 'package:firebase_database/firebase_database.dart';

class ActiveMonthYear {
  late String year;
  late String month;
  ActiveMonthYear({required this.year, required this.month});
}
//Change notifier: implementação do padrão Observer
class Records with ChangeNotifier {
  // FireBase
  // referencia CRUD: 
  // https://capsistema.com.br/index.php/2022/08/10/operacoes-crud-do-firebase-realtime-database-para-o-projeto-flutter/
  // Conexão com DB -> Coleção 'records'

  // Start with and collection for anonymus access, when user SignIn an collection must be assign to database;
  // The method setDbUser() must be called for assign an database collection for an user.
  DatabaseReference dbRecords = FirebaseDatabase.instance.ref().child('anonymus');

  //Store records
  List<Record> _items = [];
  String filter = Filter.ALL;

  
  ActiveMonthYear activeMonthYear = ActiveMonthYear(
    month: DateFormat("MM-yy").format(DateTime.now()).split('-')[0], 
    year: DateFormat("MM-yy").format(DateTime.now()).split('-')[1]
  );


  void setActiveMonthYear (String year, String month) {
    activeMonthYear.year = year;
    activeMonthYear.month = month;

    //notifyListeners();
  }

  List<Record> get items {
    //return [ ... _items];
    _items = itemsByActiveDate();
    if (filter != Filter.ALL) {
      return _items.where((element) => element.type == filter).toList();
    }
    //exlude invest for all
    return _items.where((element) => element.type != Filter.INVEST).toList();

  
  }

  List<Record> itemsByActiveDate() {
    List<Record> _itemsByDate = [];
    for (Record item in _items) {
      // if year
      if (item.date.split('-')[2] == activeMonthYear.year) {
        // if month
        if (item.date.split('-')[1] == activeMonthYear.month) {
          _itemsByDate.add(item);
        }
      }    
    }
    return _itemsByDate;
  }




  void enableLocalPersistence() {
    // Enable the local persistence and start listen add and remove Firebase actions.
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    FirebaseDatabase.instance.ref().keepSynced(true);
    //Listen snapshot data on add register
    dbRecords.onChildAdded.listen((event) { 
      debugPrint("\n\t snapshot add register \n\t>>> ${event.snapshot.key}: ${event.snapshot.value}");
      refreshRecords();
    });
    
    //Listen snapshot data on remove register
    dbRecords.onChildRemoved.listen((event) {
      debugPrint("\n\t >>> snapshot removed");
      refreshRecords();
    });
  }

  void setDbUser(String user) {
    // Set database collection for loggedIn User
    dbRecords = FirebaseDatabase.instance.ref('users/$user/records');
    refreshRecords();  
  }
  
  void refreshRecords() async {
    // Refresh the list _items with current database user records state.
    DatabaseEvent event = await dbRecords.once();
    Map<dynamic, dynamic> records = event.snapshot.value as Map<dynamic, dynamic>;
    
    _items = [];
    if (records != null) {
      records.forEach((id, recordData) { 
        _items.add(Record(
          id: id,
          type: recordData['type'],
          value: recordData['value'],
          desc: recordData['desc'],
          date: recordData['date']
        ));
      });

      _items.sort((a,b) {
        DateTime _a = DateFormat("dd-MM-yy").parse(a.date);
        DateTime _b = DateFormat("dd-MM-yy").parse(b.date);
        return _b.compareTo(_a);
        //DateTime(DateFormat("dd-MM-yy").parse(a.date));
      });

      notifyListeners();
    }

  }
  

  Future<void> addRecord(Record record) async{
    // Add a new record on database
    await dbRecords.push().set({
      "type": record.type,
      "value": record.value,
      "desc": record.desc,
      "date": record.date
    });
    notifyListeners();
  }

  // Future<void> undoDelete(Record record,) async{
  //   // @TODO: Desfazer remove (Ação da snack bar)
  //   //_items.insert(index, record);
  //   //print(record);
  //   // addRecord(record);
  //   // notifyListeners();
  //   print(record.id);
  //   print(record.value);
  // }

  Future<void> removeRecord(String id) async{
    // Remove an specific record from database
    await dbRecords.child(id).remove(); 
    notifyListeners();
  }

  String getFilter() {
    // retorna filtro ativo no momento
    // Filtros: receita; gasto; investimento ou todos; 
    refreshRecords();
    return filter;
  } 

  void setFilter(String _filter) {
    // Ativa um filtro
    // Filtros: receita; gasto; investimento ou todos; 
    switch (_filter) {
      case 'all': filter = Filter.ALL; break;
      case 'spent': filter = Filter.SPENT; break;
      case 'profit': filter = Filter.PROFIT; break;
      case 'invest': filter = Filter.INVEST; break;
    }
    notifyListeners();
  }


  // São métodos utilizados para exibir resumo de gastos/entradas
  // Somam o valor total para cada tipo de registro
  double getAllSpent() {
    double val = 0.0;
    for (Record item in itemsByActiveDate()) {
      if (item.type == 'spent') {
        val += item.value;
      }
    }
    return double.parse((val).toStringAsFixed(2));
  }

  double getAllProfit() {
    double val = 0.0;
    for (Record item in itemsByActiveDate()) {
      if (item.type == 'profit') {
        val += item.value;
      }
    }
    return double.parse((val).toStringAsFixed(2));
  }

  double getAllInvest() {
    double val = 0.0;
    for (Record item in itemsByActiveDate()) {
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

  

  // get months that have registers
  void getMonths() {
    print('getMonths() List');
  }

  // chamada no frontend
  void getDateInterval( ) {
    late List<String> recordsDates = [];

    for (Record r in _items) {
      print(r);
      recordsDates.add(r.date);
    }

    //debug
    // for (String d in recordsDates) {
    //   print(d);
    // }
  }

}
