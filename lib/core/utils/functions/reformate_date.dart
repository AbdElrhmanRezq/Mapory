String reformatDate(String timeStamp) {
  List<String> months = [
    'january',
    'february',
    'march',
    'april',
    'may',
    'june',
    'july',
    'august',
    'september',
    'october',
    'november',
    'december',
  ];

  String date = timeStamp.split('T')[0];
  String formattedDate =
      "${date.split('-')[2]} ${months[int.parse(date.split('-')[1]) - 1]} ${date.split('-')[0]}";
  return formattedDate;
}
