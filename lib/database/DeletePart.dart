import 'package:fluent_ui/fluent_ui.dart';
import 'package:partwindows/database/DBHelper.dart';
import '/database/PartModel.dart';

class DeletePart extends StatefulWidget {
  const DeletePart({Key? key}) : super(key: key);

  @override
  State<DeletePart> createState() => _DeletePartState();
}

class _DeletePartState extends State<DeletePart> {
  final dbHelper = DatabaseHelper.instance;

  init() {}

  List<Part> part = [];
  List<Part> partByName = [];

  TextEditingController nameDeleteController = TextEditingController();
  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: TextBox(
              controller: nameDeleteController,
              placeholder: 'Nazwa Części',
            ),
          ),
          FilledButton(
            onPressed: () {
              var name = nameDeleteController.text;
              _delete(name);
            },
            child: const Text('Delete Part'),
          ),
        ],
      ),
    );
  }

  _delete(name) async {
    final rowsDeleted = await dbHelper.delete(name);
  }
}
