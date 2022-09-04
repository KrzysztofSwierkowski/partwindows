import 'DBHelper.dart';

class Part {
  late int? id; // id of the part
  late String type; // type of the part
  late String number; // number of the part
  late String name; // name of the part

  Part(this.id, this.type, this.number, this.name);

  Part.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    type = map['type'];
    number = map['number'];
    name = map['name'];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnType: type,
      DatabaseHelper.columnNumber: number,
      DatabaseHelper.columnName: name,
    };
  }
}
