import 'package:partwindows/database/DBHelper.dart';

class Part {
  // late int? id; // id of the part
  late String name; // name of the part
  late String number; // number of the part
  late String type; // type of the part
  Part(this.name, this.number, this.type);

  Part.fromMap(Map<String, dynamic> map) {
    // id = map['id'];
    name = map['name'];
    number = map['number'];
    type = map['type'];
  }

  Map<String, dynamic> toMap() {
    return {
      // DatabaseHelper.columnId: id,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnNumber: number,
      DatabaseHelper.columnType: type,
    };
  }
}
