import 'package:intl/intl.dart';

String currencyFormat(double? price) {
  return price != null ? NumberFormat("#,##0.00", "en_US").format(price) : "";
}

String dateFormat(DateTime? date, bool? hasYear) {
  return date != null
      ? (hasYear != null && !hasYear
          ? DateFormat("dd/MM").format(date)
          : DateFormat("dd/MM/yyyy").format(date))
      : "";
}

String dateHourFormat(DateTime? date) {
  return date != null
      ? "${DateFormat("dd/MM/yyyy").format(date)}, ${DateFormat("HH:mm").format(date)} hs."
      : "";
}

int daysBetween(DateTime? from, DateTime? to) {
  if (from == null || to == null) return 0;
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}
