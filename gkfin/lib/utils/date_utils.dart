import "package:intl/intl.dart";

class DateUtils {
  static List<String> rangeDateInStr(List<String> inputDates) {
    
    // 1) convert inputDates to DateTime
    List<DateTime> _dates = [];
    inputDates.forEach((m)  {
      print(m.split('-'));
      int day = int.parse(m.split('-')[0]);
      int month = int.parse(m.split('-')[1]);
      int year = int.parse(m.split('-')[2]);

      _dates.add(DateTime(year, month));
    
    });


    // 2) sort dates by oldest to newest
    _dates.sort((a,b) {
      return a.compareTo(b);
    });

    // 3) get the oldes and de newest date
    DateTime oldest = _dates[0];
    DateTime newest = _dates[_dates.length - 1];

    print('\n');
    print("oldest: $oldest newest: $newest");

    // 4) build an continuos interval of dates between oldest and newst
    List<DateTime> dateInterval = [];
    DateTime currDate = oldest;
    while(true) {
      if (currDate.year == newest.year && currDate.month > newest.month) {
        break;
      }else {
        dateInterval.add(DateTime(currDate.year, currDate.month));
        currDate = DateTime(currDate.year, currDate.month + 1);
      }
    }

    // 5) Parse the range list to String in format MM-yyyyy
    DateFormat dateFormat = DateFormat("MM-yyyy");
    List<String> strRangeDates = [];

    for( var d in dateInterval) {
    strRangeDates.add(dateFormat.format(d));
    }

    for (var strDate in strRangeDates) {
    print(strDate);
    }

    return strRangeDates;
  }
}