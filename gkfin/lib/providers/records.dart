import 'package:flutter/cupertino.dart';
import 'record.dart';
import '../data/dummy_data.dart';
import '../utils/filter.dart';

// Firebase tests
import 'package:firebase_database/firebase_database.dart';


//Change notifier: implementação do padrão Observer
class Records with ChangeNotifier {
  // FireBase
  // referencia CRUD: 
  // https://capsistema.com.br/index.php/2022/08/10/operacoes-crud-do-firebase-realtime-database-para-o-projeto-flutter/
  // Conexão com DB -> Coleção 'records'
  DatabaseReference dbRecords = FirebaseDatabase.instance.ref().child('records');
    
  List<Record> _items = [];

  String filter = Filter.ALL;

  List<Record> get items {
    //return [ ... _items];
    if (filter != Filter.ALL) {
      return _items.where((element) => element.type == filter).toList();
    }
    //exlude invest for all
    return _items.where((element) => element.type != Filter.INVEST).toList();
  }


  
  void refreshRecords() async {
    // Atualiza a list _items com o estado atual do banco de dados.
    DatabaseEvent event = await dbRecords.once();
    Map<dynamic, dynamic> records = event.snapshot.value as Map<dynamic, dynamic>;
    
    _items = [];
    records.forEach((id, recordData) { 
      _items.add(Record(
        id: id,
        type: recordData['type'],
        value: recordData['value'],
        //value: double.parse(recordData['value']),
        desc: recordData['desc'],
        date: recordData['date']
      ));
    });
    notifyListeners();

  }
  

  Future<void> addRecord(Record record) async{
    // Adiciona um registro
    await dbRecords.push().set({
      "type": record.type,
      "value": record.value,
      "desc": record.desc,
      "date": record.date
    }).then((value) => notifyListeners());
    
  }

  Future<void> undoDelete(Record record,) async{
    // @TODO: Desfazer remove (Ação da snack bar)
    //_items.insert(index, record);
    //print(record);
    // addRecord(record);
    // notifyListeners();
    print(record.id);
    print(record.value);
  }

  Future<Record> removeRecord(String id) async{
    await dbRecords.child(id).remove(); // Remove o registro do banco de dados
    // recupera o registro da lista de registros carregada em memória
    Record record = _items.where((element) => element.id == id).toList()[0]; 
    // remove o registro da lista de registros carregada em memória
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    return record;
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


  // Soma o valor total para cada tipo de registro
  // São métodos utilizados para exibir resumo de gastos/entradas
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
