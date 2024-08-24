import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat('yyyy/MM/dd HH:mm');
final DateFormat formatterWithoutYear = DateFormat('MM/dd HH:mm');
final DateFormat formatterForDay = DateFormat('yyyy/MM/dd');
final DateFormat formatterForDayWithoutYear = DateFormat('MM/dd');

String durationString(DateTime startAt, DateTime endAt) {
  final startString = () {
    if (startAt.year == DateTime.now().year) {
      return formatterWithoutYear.format(startAt);
    }
    return formatter.format(startAt);
  }();

  final endString = () {
    if (endAt.year == DateTime.now().year) {
      return formatterWithoutYear.format(endAt);
    }
    return formatter.format(endAt);
  }();
  if (startString == endString) {
    return startString;
  }
  return '$startString ~ $endString';
}

String durationStringForSheet(DateTime startAt, DateTime endAt) {
  final startString = () {
    if (startAt.year == DateTime.now().year) {
      return formatterForDayWithoutYear.format(startAt);
    }
    return formatterForDay.format(startAt);
  }();

  final endString = () {
    if (endAt.year == DateTime.now().year) {
      return formatterForDayWithoutYear.format(endAt);
    }
    return formatterForDay.format(endAt);
  }();
  if (startString == endString) {
    return startString;
  }
  return '$startString ~ $endString';
}
