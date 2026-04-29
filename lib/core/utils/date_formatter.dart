import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String full(DateTime d)  => DateFormat('dd MMM yyyy', 'fr_FR').format(d);
  static String short(DateTime d) => DateFormat('dd/MM/yyyy', 'fr_FR').format(d);
  static String time(DateTime d)  => DateFormat('HH:mm', 'fr_FR').format(d);
  static String relative(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inMinutes < 1)  return 'À l\'instant';
    if (diff.inMinutes < 60) return 'Il y a ${diff.inMinutes} min';
    if (diff.inHours < 24)   return 'Il y a ${diff.inHours}h';
    if (diff.inDays == 1)    return 'Hier';
    if (diff.inDays < 7)     return 'Il y a ${diff.inDays} jours';
    return full(d);
  }
}
