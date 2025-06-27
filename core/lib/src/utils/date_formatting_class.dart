import 'package:intl/intl.dart';

class DateFormattingClass {
  static String createPeriodFromDates(DateTime startDate, DateTime endDate) {
    final String startDateFormatted = DateFormat('MM.yyyy').format(startDate);
    final String endDateFormatted = DateFormat('MM.yyyy').format(endDate);

    return '$startDateFormatted – $endDateFormatted';
  }

  static List<DateTime> parsePeriodToDates(String period) {
    final List<String> dates = period.split(' – ');

    final DateTime startDate = DateFormat('MM.yyyy').parse(dates[0]);
    final DateTime endDate = DateFormat('MM.yyyy').parse(dates[1]);

    return <DateTime>[startDate, endDate];
  }

  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM').format(date);
  }
}
