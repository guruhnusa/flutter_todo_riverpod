extension StringExt on String {
  String formatDate() {
    List<String> parts = split('/');
    if (parts.length != 3) {
      return this;
    }
    String day = parts[0].padLeft(2, '0');
    String month = parts[1].padLeft(2, '0');
    String year = parts[2];
    return '$year-$month-$day';
  }
}
