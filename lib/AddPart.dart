import 'package:fluent_ui/fluent_ui.dart';
import 'package:partwindows/DBHelper.dart';
import 'package:partwindows/PartModel.dart';

class AddPart extends StatefulWidget {
  const AddPart({Key? key}) : super(key: key);

  @override
  State<AddPart> createState() => _AddPartState();
}

class _AddPartState extends State<AddPart> {
  final dbHelper = DatabaseHelper.instance;

  init() {}

  List<Part> part = [];
  List<Part> partByName = [];

  TextEditingController typeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(25),
            child: TextBox(
              controller: nameController,
              placeholder: 'Nazwa Części',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(25),
            child: TextBox(
              controller: numberController,
              placeholder: 'Numer Części',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(25),
            child: TextBox(
              controller: typeController,
              placeholder: 'Typ Części',
            ),
          ),
          FilledButton(
            child: const Text('Dodaj część do bazy danych'),
            onPressed: () {
              String name = nameController.text;
              String type = typeController.text;
              String number = numberController.text;
              _insert(name, type, number); //todo add method
            },
          )
        ],
      ),
    );
  }

  _insert(name, type, number) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnType: type,
      DatabaseHelper.columnNumber: number
    };
    Part part = Part.fromMap(row);
    final id = await dbHelper.insert(part);
  }
}
