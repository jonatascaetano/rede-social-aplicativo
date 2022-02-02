class ConvertDate {
  static convertToDatePost({required String release}) {
    String date = '';
    DateTime now = DateTime.now();
    var difference = now.difference(DateTime.parse(release)).inMinutes;
    if (difference < 1) {
      date = "now";
    } else if (difference < 60) {
      if (difference == 1) {
        date = difference.toString() + " minute";
      } else {
        date = difference.toString() + " minutes";
      }
    } else if (difference >= 60 && difference < 1440) {
      difference = now.difference(DateTime.parse(release)).inHours;
      if (difference == 1) {
        date = difference.toString() + " hour";
      } else {
        date = difference.toString() + " hours";
      }
    } else if (difference >= 1440 && difference < 43200) {
      difference = now.difference(DateTime.parse(release)).inDays;
      if (difference == 1) {
        date = difference.toString() + " day";
      } else {
        date = difference.toString() + " days";
      }
    } else if (difference >= 43200 && difference < 518400) {
      difference = now.difference(DateTime.parse(release)).inDays;
      if (difference >= 30 && difference < 60) {
        date = difference.toString() + " month";
      } else {
        date = difference.toString() + " months";
      }
    } else if (difference >= 518400) {
      difference = now.difference(DateTime.parse(release)).inDays;
      if (difference >= 365 && difference <= 730) {
        date = int.parse((difference / 365).toString()).toString() + " year";
      } else {
        date = int.parse((difference / 365).toString()).toString() + " years";
      }
    }

    return date;
  }
}
