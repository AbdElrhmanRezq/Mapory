String reformatDate(String timeStamp) {
  List months = [
    'jan',
    'feb',
    'mar',
    'april',
    'may',
    'jun',
    'july',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec',
  ];
  String date = timeStamp.split('T')[0];
  String formattedDate =
      "${date.split('-')[2]} ${months[int.parse(date.split('-')[1]) - 1]} ${date.split('-')[0]}";
  return formattedDate;
}
