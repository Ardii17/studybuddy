import 'package:app/object/class.dart';

class Dailyclass {
  final String day;
  final int? classCount;
  final String? query;
  List<Class>? allClass;

  Dailyclass({required this.day, this.classCount, this.allClass, this.query}) {
    allClass = [];
  }

  void addClass(Class theClass){
    allClass?.add(theClass);
  }

  String toString(){
    return 'day: $day, Class Count: $classCount';
  }
}