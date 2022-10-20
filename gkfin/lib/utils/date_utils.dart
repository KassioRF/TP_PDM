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

      _dates.add(DateTime(year, month, day));
    
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
    DateFormat dateFormat = DateFormat("dd-MM-yy");
    List<String> strRangeDates = [];

    for( var d in dateInterval) {
    strRangeDates.add(dateFormat.format(d));
    }

    for (var strDate in strRangeDates) {
    print(strDate);
    }

    return strRangeDates;
  }

  static DateTime parseStrToDateTime(String dateStr) {
    int day = int.parse(dateStr.split('-')[0]);
    int month = int.parse(dateStr.split('-')[1]);
    int year = int.parse(dateStr.split('-')[2]);

    return DateTime(year, month, day);
  }
  
  static String parseDateTimeToStr(DateTime date) {
    // Converte um DateTime em uma String no formato dd-MM-yyyy
    DateFormat dateFormat = DateFormat("dd-MM-yy");
    return dateFormat.format(date);
  }


  static List<String> sortDateTimeByOldest(List<String> datesStr) {
    datesStr.sort((a,b) => a.compareTo(b));
    return datesStr;
  }
  static List<String> sortDateTimeByNewest(List<String> datesStr) {
    datesStr.sort((a,b) => b.compareTo(a));
    return datesStr;
  }
  // static List<DateTime> sortDateTimeByOldest(List<DateTime> dates) {    
  //   dates.sort((a,b) {
  //     return a.compareTo(b);
  //   });
  //   return dates;
  // }
  // static List<DateTime> sortDateTimeByNewest(List<DateTime> dates) {
  //   dates.sort((a,b) {
  //     return b.compareTo(a);
  //   });      
  //   return dates;
  // }


}