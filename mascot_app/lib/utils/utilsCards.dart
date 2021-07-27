import 'package:intl/intl.dart';

class UtilsCards {
  static String birthdayDateTime(DateTime dateTime){
    final birthDay = DateFormat.yMMMEd().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);

    return '$birthDay $time';
  }

  static String birthDayTime(DateTime dateTime){
    final birthDay = DateFormat.yMMMEd().format(dateTime);

    return '$birthDay';
  }

}