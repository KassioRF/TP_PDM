import 'package:flutter/widgets.dart';

class Record with ChangeNotifier {
  final String id;
  final String type;
  final num value;
  final String desc;
  final String date;
  //add date

  Record({
    required this.id,
    required this.type,
    required this.value,
    required this.desc,
    required this.date,
  });
  
}
