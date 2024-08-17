import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat('yyyy/MM/dd HH:mm');

String durationString(DateTime startAt, DateTime endAt) {
  return '${formatter.format(startAt)} ~ ${formatter.format(endAt)}';
}
