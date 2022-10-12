import 'package:fluent_ui/fluent_ui.dart';
import '/database/DBHelper.dart';
import '/database/PartModel.dart';

class ChangePart extends StatefulWidget {
  const ChangePart({Key? key}) : super(key: key);

  @override
  State<ChangePart> createState() => _ChangePartState();
}

class _ChangePartState extends State<ChangePart> {
  final dbHelper = DatabaseHelper.instance;

  init() {}

  List<Part> part = [];
  List<Part> partByName = [];

  TextEditingController idUpdateController = TextEditingController();
  TextEditingController nameUpdateController = TextEditingController();
  TextEditingController numberUpdateController = TextEditingController();
  TextEditingController typeUpdateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          // Container(
          //   padding: const EdgeInsets.all(20),
          //   child: TextBox(
          //     controller: idUpdateController,
          //     placeholder: 'Id Części',
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.all(20),
            child: TextBox(
              controller: nameUpdateController,
              placeholder: 'Nazwa Części',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: TextBox(
              controller: numberUpdateController,
              placeholder: 'Numer Części',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: TextBox(
              controller: typeUpdateController,
              placeholder: 'Typ Części',
            ),
          ),
          FilledButton(
            onPressed: () {
             // int id = int.parse(idUpdateController.text);
              String name = nameUpdateController.text;
              String number = numberUpdateController.text;
              String type = typeUpdateController.text;
              _update(name, number, type);
            },
            child: const Text('Zaktualizuj'),
          ),
        ],
      ),
    );
  }

  _update(name, number, type) async {
    Part part = Part(name, number, type);
    final rowsAffected = await dbHelper.update(part);
  }
}
